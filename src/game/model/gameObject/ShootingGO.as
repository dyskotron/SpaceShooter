package game.model.gameObject
{
    import game.model.gameObject.vo.ShootingVO;
    import game.model.weapon.ComponentSlot;
    import game.model.weapon.IWeaponComponent;
    import game.model.weapon.enums.ComponentType;

    import org.osflash.signals.Signal;

    public class ShootingGO extends HittableGO
    {
        protected var _weapons: Vector.<IWeaponComponent>;

        private var _shootSignal: Signal;
        private var _shootingVO: ShootingVO;

        /**
         * Base class for all game objects which are able to shoot
         * @param aShootingVO
         * @param aX
         * @param aY
         * @param aSpeedX
         * @param aSpeedY
         */
        public function ShootingGO(aShootingVO: ShootingVO, aX: Number, aY: Number, aSpeedX: Number = 0, aSpeedY: Number = 0)
        {
            super(aShootingVO, aX, aY, aSpeedX, aSpeedY);

            _shootingVO = aShootingVO;
            _shootSignal = new Signal(Vector.<BulletGO>);

            installComponents();
        }

        public function get shootSignal(): Signal
        {
            return _shootSignal;
        }

        override public function update(aDeltaTime: int): void
        {
            for (var i: int = 0; i < _weapons.length; i++)
            {
                _weapons[i].update(aDeltaTime, x, y);
            }

            super.update(aDeltaTime);
        }

        public function startShoot(): void
        {
            for (var i: int = 0; i < _weapons.length; i++)
            {
                _weapons[i].startShoot();
            }
        }

        public function endShoot(): void
        {
            for (var i: int = 0; i < _weapons.length; i++)
            {
                _weapons[i].stopShoot();
            }
        }

        protected function installComponents(): void
        {
            _weapons = new Vector.<IWeaponComponent>();

            if (_shootingVO.componentSlots)
            {
                var weaponSlot: ComponentSlot;

                for (var i: int = 0; i < _shootingVO.componentSlots.length; i++)
                {
                    weaponSlot = _shootingVO.componentSlots[i];
                    if (weaponSlot.isType(ComponentType.GUNS))
                    {
                        if (weaponSlot.isType(ComponentType.GUNS))
                            _weapons.push(createWeapon(_shootSignal, weaponSlot));
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
