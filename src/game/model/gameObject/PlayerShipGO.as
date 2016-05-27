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

    import game.model.gameObject.constants.BonusType;
    import game.model.gameObject.vo.PlayerShipVO;
    import game.model.weapon.PlayerWeapon;
    import game.model.weapon.Weapon;

    import org.osflash.signals.Signal;

    public class PlayerShipGO extends ShootingGO
    {
        public static const STATE_DEAD: uint = 0;
        public static const STATE_WAITING: uint = 1;
        public static const STATE_ALIVE: uint = 2;
        public static const STATE_SPAWNING: uint = 3;

        public static const MOVE_EASING: Number = 0.2;

        /**
         * Coordinates where player ship is heading to.
         * it stores mouse position for mouse controller
         * or "keyboard position" emulated from keys presses by KeyController
         */
        public var controlX: Number = 0;
        public var controlY: Number = 0;

        private var _playerID: uint;
        private var _playerShipVO: PlayerShipVO;
        private var _statsUpdateSignal: Signal;
        private var _changeStateSignal: Signal;
        private var _playerDiedSignal: Signal;

        //stats shown on gui
        private var _state: uint;
        private var _lives: int = 3;
        private var _score: Number = 0;

        public function PlayerShipGO(aPLayerID: uint, aPlayerShipVO: PlayerShipVO): void
        {
            super(aPlayerShipVO, 0, 0, 0, 0);

            _playerID = aPLayerID;
            _playerShipVO = aPlayerShipVO;
            _statsUpdateSignal = new Signal();
            _changeStateSignal = new Signal(PlayerShipGO);
            _playerDiedSignal = new Signal(uint);
        }

        public function get playerShipVO(): PlayerShipVO
        {
            return _playerShipVO;
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

        public function get score(): Number
        {
            return _score;
        }

        public function set score(value: Number): void
        {
            _score = value;
            _statsUpdateSignal.dispatch();
        }

        public function get weaponPower(): uint
        {
            return PlayerWeapon(_weapon).displayedPower;
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

        override public function startShoot(): void
        {
            if (state == STATE_ALIVE)
                super.startShoot();
        }

        public function init(aX: Number, aY: Number): void
        {
            x = controlX = aX;
            y = controlY = aY;
            _state = STATE_ALIVE;
        }

        override public function update(aDeltaTime: int): void
        {
            speedX = (controlX - x) * MOVE_EASING;
            speedY = (controlY - y) * MOVE_EASING;

            x += speedX;
            y += speedY;

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
                    PlayerWeapon(_weapon).addPower();
                    break;
            }

            _statsUpdateSignal.dispatch();
        }

        override public function destroy(): void
        {

        }

        override protected function createWeapon(aShootSignal: Signal, aShootInterval: int, aX: Number = 0, aY: Number = 0): Weapon
        {
            return new PlayerWeapon(aShootSignal, aShootInterval, aX, aY);
        }

        private function die(): void
        {
            _lives = Math.max(--_lives, 0);
            PlayerWeapon(_weapon).onDeath();

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
    }
}
