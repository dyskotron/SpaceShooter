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

    import game.model.gameObject.components.ComponentType;
    import game.model.gameObject.components.generator.BatteryModel;
    import game.model.gameObject.components.generator.EnergyComponent;
    import game.model.gameObject.components.generator.GeneratorModel;
    import game.model.gameObject.components.generator.IGeneratorComponent;
    import game.model.gameObject.components.generator.IGeneratorGO;
    import game.model.gameObject.components.weapon.ComponentSlot;
    import game.model.gameObject.components.weapon.IWeaponComponent;
    import game.model.gameObject.components.weapon.PlayerWeaponComponent;
    import game.model.gameObject.components.weapon.WeaponModel;
    import game.model.gameObject.constants.BonusTypeID;
    import game.model.gameObject.fsm.ITargetProvider;
    import game.model.gameObject.vo.PlayerShipVO;

    import org.osflash.signals.Signal;

    public class PlayerShipGO extends ShootingGO implements IGeneratorGO
    {
        public static const STATE_DEAD: uint = 0;
        public static const STATE_WAITING: uint = 1;
        public static const STATE_ALIVE: uint = 2;
        public static const STATE_SPAWNING: uint = 3;

        public static const MOVE_EASING: Number = 0.4;

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

        private var _shouldBeShooting: Boolean;

        //stats shown on gui
        private var _state: uint;
        private var _lives: int = 3;
        private var _score: Number = 0;
        private var _generatorComponent: IGeneratorComponent;

        public function PlayerShipGO(aPLayerID: uint, aPlayerShipVO: PlayerShipVO, aTargetProvider: ITargetProvider): void
        {
            _playerID = aPLayerID;
            _playerShipVO = aPlayerShipVO;
            _statsUpdateSignal = new Signal();
            _changeStateSignal = new Signal(PlayerShipGO);
            _playerDiedSignal = new Signal(uint);

            super(aPlayerShipVO, aTargetProvider, 0, 0, 0, 0);
        }

        //region ==================== SETTERS & GETTERS ====================
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
            return PlayerWeaponComponent(_weapons[0]).displayedPower;
        }

        public function get generatorComponent(): IGeneratorComponent
        {
            return _generatorComponent;
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

        //endregion

        override public function startShoot(): void
        {
            _shouldBeShooting = true;

            if (state == STATE_ALIVE)
                super.startShoot();
        }

        override public function endShoot(): void
        {
            _shouldBeShooting = false;
            super.endShoot();
        }

        override public function chargeShoot(): void
        {
            if (state == STATE_ALIVE)
                super.chargeShoot();
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

            _generatorComponent.update(aDeltaTime);
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
                case BonusTypeID.BONUS_HEALTH:
                    addHitPoints(80);
                    break;
                case BonusTypeID.BONUS_LIFE:
                    _lives++;
                    break;
                case BonusTypeID.BONUS_WEAPON:
                    weaponsAddPower();
                    break;
            }

            _statsUpdateSignal.dispatch();
        }

        /**
         * Debug function
         */
        public function powerDown(): void
        {
            weaponsOnDeath();
        }

        /**
         * Debug function
         */
        public function switchMainWeapon(aWeaponModel: WeaponModel): void
        {
            _weapons[0] = new PlayerWeaponComponent(this, shootSignal, aWeaponModel, _playerID, _targetProvider, PlayerWeaponComponent(_weapons[0]).x, PlayerWeaponComponent(_weapons[0]).y, PlayerWeaponComponent(_weapons[0]).power);
        }

        override public function destroy(): void
        {

        }

        override protected function mountComponents(): void
        {
            var capacity: Number = 0;
            var rechargeSpeed: Number = 0;

            if (_playerShipVO.componentSlots)
            {
                var componentSlot: ComponentSlot;

                for (var i: int = 0; i < _playerShipVO.componentSlots.length; i++)
                {
                    componentSlot = _playerShipVO.componentSlots[i];

                    if (componentSlot.isType(ComponentType.GENERATOR))
                    {
                        rechargeSpeed += GeneratorModel(componentSlot.componentModel).rechargeSpeed;
                    }
                    else if (componentSlot.isType(ComponentType.BATTERY))
                    {
                        capacity += BatteryModel(componentSlot.componentModel).capacity;
                    }
                }
            }

            _generatorComponent = new EnergyComponent(capacity, rechargeSpeed);

            super.mountComponents();
        }

        override protected function createWeapon(aShootSignal: Signal, aComponentSLot: ComponentSlot): IWeaponComponent
        {
            return new PlayerWeaponComponent(this, aShootSignal, WeaponModel(aComponentSLot.componentModel), _playerID, _targetProvider, aComponentSLot.x, aComponentSLot.y);
        }

        private function die(): void
        {
            _lives = Math.max(--_lives, 0);
            weaponsOnDeath();

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

            if (_shouldBeShooting)
                startShoot();
        }

        private function dispatchDied(): void
        {
            _playerDiedSignal.dispatch(_playerID)
        }

        private function weaponsOnDeath(): void
        {
            for (var i: int = 0; i < _weapons.length; i++)
            {
                PlayerWeaponComponent(_weapons[i]).onDeath();
            }
        }

        private function weaponsAddPower(): void
        {
            for (var i: int = 0; i < _weapons.length; i++)
            {
                PlayerWeaponComponent(_weapons[i]).addPower();
            }
        }
    }
}
