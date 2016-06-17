package game.model.gameObject
{
    import game.model.gameObject.components.ComponentType;
    import game.model.gameObject.components.weapon.ComponentSlot;
    import game.model.gameObject.components.weapon.IWeaponComponent;
    import game.model.gameObject.components.weapon.WeaponModel;
    import game.model.gameObject.components.weapon.enums.WeaponGroup;
    import game.model.gameObject.fsm.ITargetProvider;
    import game.model.gameObject.vo.ShootingVO;

    import org.osflash.signals.Signal;

    public class ShootingGO extends HittableGO
    {
        protected var _targetProvider: ITargetProvider;

        protected var _weapons: Vector.<IWeaponComponent>;
        private var _chargeWeapons: Vector.<IWeaponComponent>;

        private var _shootSignal: Signal;
        private var _shootingVO: ShootingVO;
        private var _isShooting: Boolean;

        /**
         * Base class for all game objects which are able to shoot
         * @param aShootingVO
         * @param aX
         * @param aY
         * @param aSpeedX
         * @param aSpeedY
         */
        public function ShootingGO(aShootingVO: ShootingVO, aTargetProvider: ITargetProvider, aX: Number, aY: Number, aSpeedX: Number = 0, aSpeedY: Number = 0)
        {
            super(aShootingVO, aX, aY, aSpeedX, aSpeedY);

            _shootingVO = aShootingVO;
            _shootSignal = new Signal(Vector.<BulletGO>);
            _targetProvider = aTargetProvider;

            mountComponents();
        }

        public function get shootSignal(): Signal
        {
            return _shootSignal;
        }

        public function get isShooting(): Boolean
        {
            return _isShooting;
        }

        override public function update(aDeltaTime: int): void
        {
            for (var i: int = 0; i < _weapons.length; i++)
            {
                _weapons[i].update(aDeltaTime);
            }

            super.update(aDeltaTime);
        }

        public function startShoot(): void
        {
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
            for (var i: int = 0; i < _chargeWeapons.length; i++)
            {
                _chargeWeapons[i].shoot(transform.x, transform.y);
            }
        }

        protected function mountComponents(): void
        {
            _weapons = new Vector.<IWeaponComponent>();
            _chargeWeapons = new Vector.<IWeaponComponent>();

            if (_shootingVO.componentSlots)
            {
                var weaponSlot: ComponentSlot;

                for (var i: int = 0; i < _shootingVO.componentSlots.length; i++)
                {
                    weaponSlot = _shootingVO.componentSlots[i];
                    if (weaponSlot.isType(ComponentType.GUNS))
                    {
                        if (WeaponModel(weaponSlot.componentModel).weaponGroup == WeaponGroup.NORMAL)
                            _weapons.push(createWeapon(_shootSignal, weaponSlot));
                        else if (WeaponModel(weaponSlot.componentModel).weaponGroup == WeaponGroup.CHARGE)
                            _chargeWeapons.push(createWeapon(_shootSignal, weaponSlot));
                    }
                }
            }
        }

        /**
         * Abstract weapon factory method
         * @param aShootSignal
         * @param aWeaponVO
         * @return
         */
        protected function createWeapon(aShootSignal: Signal, aWeaponVO: ComponentSlot): IWeaponComponent
        {
            return null;
        }

    }
}
