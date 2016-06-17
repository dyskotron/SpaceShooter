package game.model.gameObject.components.controll
{
    import game.model.GameObject;
    import game.model.gameObject.BulletGO;
    import game.model.gameObject.PlayerShipGO;
    import game.model.gameObject.components.Component;
    import game.model.gameObject.components.IComponent;
    import game.model.gameObject.components.health.HealthComponent;
    import game.model.gameObject.components.health.HealthState;
    import game.model.gameObject.components.health.IHealthComponent;
    import game.model.gameObject.components.transform.TransformComponent;
    import game.model.gameObject.components.weapon.ComponentSlot;
    import game.model.gameObject.components.weapon.IWeaponComponent;
    import game.model.gameObject.components.weapon.PlayerWeaponComponent;
    import game.model.gameObject.components.weapon.WeaponModel;
    import game.model.gameObject.components.weapon.enums.WeaponGroup;
    import game.model.gameObject.vo.ShootingVO;

    import org.osflash.signals.Signal;

    public class WeaponControlComponent extends Component
    {
        private var _isShooting: Boolean;

        private var _weapons: Vector.<IWeaponComponent>;
        private var _chargeWeapons: Vector.<IWeaponComponent>;

        private var _transform: TransformComponent;
        private var _healthComponent: HealthComponent;
        private var _shootSignal: Signal;

        public function WeaponControlComponent()
        {
            _weapons = new Vector.<IWeaponComponent>();
            _chargeWeapons = new Vector.<IWeaponComponent>();
            _shootSignal = new Signal(Vector.<BulletGO>);
        }

        public function get shootSignal(): Signal
        {
            return _shootSignal;
        }

        override public function init(aGameObject: GameObject): void
        {
            super.init(aGameObject);

            _transform = gameObject.transform;

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

        public function startShoot(): void
        {
            if (_healthComponent.state != HealthState.ALIVE)
                return;

            for (var i: int = 0; i < _weapons.length; i++)
            {
                _weapons[i].startShoot();
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

        public function switchMainWeapon(aWeaponModel: WeaponModel): void
        {
            var shootingVO: ShootingVO = ShootingVO(gameObject.gameObjectVO);
            var weaponSlot: ComponentSlot;

            if (shootingVO.componentSlots)
            {
                for (var i: int = 0; i < shootingVO.componentSlots.length; i++)
                {
                    weaponSlot = shootingVO.componentSlots[i];
                }
            }

            _weapons[0] = new PlayerWeaponComponent(aWeaponModel, PlayerShipGO(gameObject).playerID, PlayerShipGO(gameObject).targetProvider, weaponSlot.x, weaponSlot.y, weaponPower);
            _weapons[0].init(gameObject);
        }
    }
}
