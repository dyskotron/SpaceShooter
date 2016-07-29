package game.model.gameObject.component.control
{
    import game.model.GameObject;
    import game.model.gameObject.component.Component;
    import game.model.gameObject.component.IComponent;
    import game.model.gameObject.component.fsm.ITargetProvider;
    import game.model.gameObject.component.health.HealthComponent;
    import game.model.gameObject.component.health.HealthState;
    import game.model.gameObject.component.health.IHealthComponent;
    import game.model.gameObject.component.transform.TransformComponent;
    import game.model.gameObject.component.weapon.IWeaponComponent;
    import game.model.gameObject.component.weapon.PlayerWeaponComponent;
    import game.model.gameObject.component.weapon.enums.WeaponGroup;
    import game.model.gameObject.goDef.GameObjectGroupID;

    import org.osflash.signals.Signal;

    public class WeaponControlComponent extends Component
    {
        private var _isShooting: Boolean;

        private var _weapons: Vector.<IWeaponComponent>;
        private var _chargeWeapons: Vector.<IWeaponComponent>;

        private var _transform: TransformComponent;
        private var _healthComponent: HealthComponent;
        private var _shootSignal: Signal;

        private var _targetProvider: ITargetProvider;

        public function WeaponControlComponent(aTargetProvider: ITargetProvider = null)
        {
            _shootSignal = new Signal(Vector.<GameObject>);
            _targetProvider = aTargetProvider;
        }

        public function get shootSignal(): Signal
        {
            return _shootSignal;
        }

        public function get targetProvider(): ITargetProvider
        {
            return _targetProvider;
        }

        override public function init(aGameObject: GameObject): void
        {
            //TODO: FIXME: its called twice on game start(for playership)
            super.init(aGameObject);
            if (aGameObject.identity.gameObjectGroup == GameObjectGroupID.PLAYER_SHIP)
                trace("_MO_", this, "================>INIT");

            _transform = gameObject.transform;
            _weapons = new Vector.<IWeaponComponent>();
            _chargeWeapons = new Vector.<IWeaponComponent>();

            var weaponsComponents: Vector.<IComponent> = getGOComponents(IWeaponComponent);
            var weaponComponent: IWeaponComponent;

            for (var i: int = 0; i < weaponsComponents.length; i++)
            {
                weaponComponent = IWeaponComponent(weaponsComponents[i]);

                if (weaponComponent.weaponModel.weaponGroup == WeaponGroup.NORMAL)
                    _weapons.push(weaponComponent);
                else if (weaponComponent.weaponModel.weaponGroup == WeaponGroup.CHARGE)
                    _chargeWeapons.push(weaponComponent);
            }

            _healthComponent = HealthComponent(getGOComponent(IHealthComponent));

        }

        public function get isShooting(): Boolean
        {
            return _isShooting;
        }

        public function startShoot(aNextShotAfter: Number = 0): void
        {
            if (_healthComponent.state != HealthState.ALIVE)
                return;

            for (var i: int = 0; i < _weapons.length; i++)
            {
                _weapons[i].startShoot(aNextShotAfter);
            }

            _isShooting = true;
        }

        public function endShoot(): void
        {
            for (var i: int = 0; i < _weapons.length; i++)
            {
                _weapons[i].endShoot();
            }

            _isShooting = false;
        }

        public function chargeShoot(): void
        {
            if (_healthComponent.state != HealthState.ALIVE)
                return;

            for (var i: int = 0; i < _chargeWeapons.length; i++)
            {
                _chargeWeapons[i].shoot(_transform.x, _transform.y);
            }
        }


        ///JUST PLAYER STUFF SPLIT TO BASE AND PLAYER CLASSES?

        public function weaponsOnDeath(): void
        {
            for (var i: int = 0; i < _weapons.length; i++)
            {
                PlayerWeaponComponent(_weapons[i]).onDeath();
            }
        }

        public function weaponsAddPower(): void
        {
            for (var i: int = 0; i < _weapons.length; i++)
            {
                PlayerWeaponComponent(_weapons[i]).addPower();
            }
        }

        public function get weaponPower(): uint
        {
            if (_weapons.length > 0)
                return PlayerWeaponComponent(_weapons[0]).displayedPower;

            return 0;
        }
    }
}
