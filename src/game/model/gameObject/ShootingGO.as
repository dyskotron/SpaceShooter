package game.model.gameObject
{
    import game.model.gameObject.vo.ShootingVO;
    import game.model.weapon.IWeaponComponent;
    import game.model.weapon.WeaponModel;

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
            _weapons = new Vector.<IWeaponComponent>();

            if (_shootingVO.weaponModels)
            {
                for (var i: int = 0; i < _shootingVO.weaponModels.length; i++)
                {
                    _weapons.push(createWeapon(_shootSignal, _shootingVO.weaponModels[i]));
                }
            }
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

        /**
         * Abstract weapon factory method
         * @param aShootSignal
         * @param aWeaponVO
         * @param aX
         * @param aY
         * @return
         */
        protected function createWeapon(aShootSignal: Signal, aWeaponVO: WeaponModel, aX: Number = 0, aY: Number = 0): IWeaponComponent
        {
            return null;
        }
    }
}
