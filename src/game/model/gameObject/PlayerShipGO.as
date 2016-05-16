/**
 * Created with IntelliJ IDEA.
 * User: DYSKO
 * Date: 5/18/13
 * Time: 9:11 PM
 * To change this template use File | Settings | File Templates.
 */
package game.model.gameObject
{
    import com.greensock.TweenLite;

    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import game.model.gameObject.constants.BonusType;
    import game.model.gameObject.constants.BulletType;
    import game.model.gameObject.vo.BulletVO;
    import game.model.gameObject.vo.PlayerShipVO;

    import org.osflash.signals.Signal;

    public class PlayerShipGO extends ShootingGO
    {
        public static const STATE_DEAD: uint = 0;
        public static const STATE_WAITING: uint = 1;
        public static const STATE_ALIVE: uint = 2;
        public static const STATE_SPAWNING: uint = 3;

        public static const WEAPON_MIN: uint = 1;
        public static const WEAPON_MAX: uint = 10;
        public static const MOVE_EASING: Number = 0.2;

        /**
         * Coordinates where player ship is heading to.
         * it stores mouse position for mouse controller
         * or "keyboard position" emulated from keys presses by KeyController
         */
        public var controlX: Number = 0;
        public var controlY: Number = 0;

        private var _playerID: uint;
        private var _shootTimer: Timer;
        private var _statsUpdateSignal: Signal;
        private var _changeStateSignal: Signal;
        private var _playerDiedSignal: Signal;

        //stats shown on gui
        private var _state: uint;
        private var _lives: uint = 3;
        private var _score: Number = 0;
        private var _weaponPower: uint = 1;

        public function PlayerShipGO(aPLayerID: uint, aPlayerShipVO: PlayerShipVO): void
        {
            super(aPlayerShipVO, 0, 0, 0, 0);

            _playerID = aPLayerID;
            _shootTimer = new Timer(100);
            _shootTimer.addEventListener(TimerEvent.TIMER, shoot, false, 0, true);
            _statsUpdateSignal = new Signal();
            _changeStateSignal = new Signal(PlayerShipGO);
            _playerDiedSignal = new Signal(uint);
        }

        public function get playerShipVO(): PlayerShipVO
        {
            return PlayerShipVO(_gameObjectVO);
        }

        public function get playerID(): uint
        {
            return _playerID;
        }

        public function get state(): uint
        {
            return _state;
        }

        public function get lives(): uint
        {
            return _lives;
        }

        public function get weaponPower(): uint
        {
            if (_weaponPower == 10)
                return 7;
            else if (_weaponPower > 6)
                return 6;

            return _weaponPower;
        }

        public function get score(): Number
        {
            return _score;
        }

        public function set score(value: Number): void
        {
            _score = value;
            _statsUpdateSignal.dispatch();
        }

        public function get statsUpdateSignal(): Signal
        {
            return _statsUpdateSignal;
        }

        public function get changeStateSignal(): Signal
        {
            return _changeStateSignal;
        }

        public function get playerDiedSignal(): Signal
        {
            return _playerDiedSignal;
        }

        public function init(aX: Number, aY: Number): void
        {
            _x = controlX = aX;
            _y = controlY = aY;
            _state = STATE_ALIVE;
        }

        override public function update(aDeltaTime: int): void
        {
            _speedX = (controlX - _x) * MOVE_EASING;
            _speedY = (controlY - _y) * MOVE_EASING;

            _x += _speedX;
            _y += _speedY;

            super.update(aDeltaTime);
        }

        override public function hit(aDamage: Number): void
        {
            super.hit(aDamage);
            if (hp <= 0)
                die();

            _statsUpdateSignal.dispatch();
        }

        public function getBonus(typeID: uint): void
        {
            switch (typeID)
            {
                case BonusType.BONUS_HEALTH:
                    addHitPoints(80);
                    break;
                case BonusType.BONUS_LIFE:
                    _lives++;
                    break;
                case BonusType.BONUS_WEAPON:
                    _weaponPower = Math.min(++_weaponPower, WEAPON_MAX);
                    break;
            }

            _statsUpdateSignal.dispatch();
        }

        override public function destroy(): void
        {
            _shootTimer.stop();
            _shootTimer.removeEventListener(TimerEvent.TIMER, shoot);
            _shootTimer = null;
        }

        private function die(): void
        {
            _lives--;
            _weaponPower = Math.max(Math.floor(_weaponPower / 2), WEAPON_MIN);

            if (_lives > 0)
            {
                _state = STATE_WAITING;
                TweenLite.delayedCall(1, spawn);
            }
            else
            {
                _state = STATE_DEAD;
                TweenLite.delayedCall(1.5, dispatchDied);
            }
            _changeStateSignal.dispatch(this);
        }

        private function spawn(): void
        {
            _state = STATE_SPAWNING;
            TweenLite.delayedCall(1.5, setAlive);
            _changeStateSignal.dispatch(this);
        }

        private function setAlive(): void
        {
            _state = STATE_ALIVE;
            setFullHealth();

            _changeStateSignal.dispatch(this);
            _statsUpdateSignal.dispatch();
        }

        private function dispatchDied(): void
        {
            _playerDiedSignal.dispatch(_playerID)
        }

        override protected function shoot(): void
        {
            if (_state != STATE_ALIVE)
                return;

            var bullets: Vector.<BulletGO> = new Vector.<BulletGO>();
            var bulletVO: BulletVO = new BulletVO(BulletType.LASER, 10, 4, 10);

            switch (_weaponPower)
            {
                case 1:
                    bullets.push(new BulletGO(_playerID, bulletVO, x, y - 40, 0, -0.6));
                    break;
                case 2:
                    bullets.push(new BulletGO(_playerID, bulletVO, x + 3, y - 40, 0, -0.6));
                    bullets.push(new BulletGO(_playerID, bulletVO, x - 3, y - 40, 0, -0.6));
                    break;
                case 3:
                    bullets.push(new BulletGO(_playerID, bulletVO, x, y - 40, 0, -0.6));
                    bullets.push(new BulletGO(_playerID, bulletVO, x - 45, y - 25, -0.1, -0.6));
                    bullets.push(new BulletGO(_playerID, bulletVO, x + 45, y - 25, 0.1, -0.6));
                    break;

                case 4:
                    bullets.push(new BulletGO(_playerID, bulletVO, x + 3, y - 40, 0, -0.6));
                    bullets.push(new BulletGO(_playerID, bulletVO, x - 3, y - 40, 0, -0.6));

                    bullets.push(new BulletGO(_playerID, bulletVO, x - 45, y - 25, -0.1, -0.6));
                    bullets.push(new BulletGO(_playerID, bulletVO, x + 45, y - 25, 0.1, -0.6));
                    break;

                case 5:
                    bullets.push(new BulletGO(_playerID, bulletVO, x, y - 40, 0, -0.6));

                    bullets.push(new BulletGO(_playerID, bulletVO, x - 47, y - 25, -0.1, -0.6));
                    bullets.push(new BulletGO(_playerID, bulletVO, x - 53, y - 25, -0.1, -0.6));

                    bullets.push(new BulletGO(_playerID, bulletVO, x + 47, y - 25, 0.1, -0.6));
                    bullets.push(new BulletGO(_playerID, bulletVO, x + 53, y - 25, 0.1, -0.6));
                    break;

                case 6:
                case 7:
                case 8:
                case 9:
                    bullets.push(new BulletGO(_playerID, bulletVO, x + 3, y - 40, 0, -0.6));
                    bullets.push(new BulletGO(_playerID, bulletVO, x - 3, y - 40, 0, -0.6));

                    bullets.push(new BulletGO(_playerID, bulletVO, x - 47, y - 25, -0.1, -0.6));
                    bullets.push(new BulletGO(_playerID, bulletVO, x - 53, y - 25, -0.1, -0.6));

                    bullets.push(new BulletGO(_playerID, bulletVO, x + 47, y - 25, 0.1, -0.6));
                    bullets.push(new BulletGO(_playerID, bulletVO, x + 53, y - 25, 0.1, -0.6));
                    break;

                case 10:
                    bullets.push(new BulletGO(_playerID, bulletVO, x + 9, y - 40, 0, -0.6));
                    bullets.push(new BulletGO(_playerID, bulletVO, x + 3, y - 40, 0, -0.6));
                    bullets.push(new BulletGO(_playerID, bulletVO, x - 3, y - 40, 0, -0.6));
                    bullets.push(new BulletGO(_playerID, bulletVO, x - 9, y - 40, 0, -0.6));

                    bullets.push(new BulletGO(_playerID, bulletVO, x - 47, y - 25, -0.1, -0.6));
                    bullets.push(new BulletGO(_playerID, bulletVO, x - 53, y - 25, -0.1, -0.6));

                    bullets.push(new BulletGO(_playerID, bulletVO, x + 47, y - 25, 0.1, -0.6));
                    bullets.push(new BulletGO(_playerID, bulletVO, x + 53, y - 25, 0.1, -0.6));
            }

            shootSignal.dispatch(bullets);
            super.shoot();
        }
    }
}
