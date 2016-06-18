package game.model.gameObject
{
    import game.model.gameObject.components.ComponentType;
    import game.model.gameObject.components.control.WeaponControlComponent;
    import game.model.gameObject.components.weapon.ComponentSlot;
    import game.model.gameObject.components.weapon.IWeaponComponent;
    import game.model.gameObject.fsm.ITargetProvider;
    import game.model.gameObject.vo.ShootingVO;

    import org.osflash.signals.Signal;

    public class ShootingGO extends HittableGO
    {
        private var _targetProvider: ITargetProvider;
        private var _shootingVO: ShootingVO;

        protected var _weaponControl: WeaponControlComponent;

        /**
         * Base class for all game objects which are able to shoot
         * @param aShootingVO
         * @param aTargetProvider
         * @param aX
         * @param aY
         * @param aSpeedX
         * @param aSpeedY
         */
        public function ShootingGO(aShootingVO: ShootingVO, aTargetProvider: ITargetProvider, aX: Number, aY: Number, aSpeedX: Number = 0, aSpeedY: Number = 0)
        {
            super(aShootingVO, aX, aY, aSpeedX, aSpeedY);

            _shootingVO = aShootingVO;
            _targetProvider = aTargetProvider;


            _weaponControl = new WeaponControlComponent();
            addComponent(_weaponControl);

            mountComponents();

            //TODO unify with guns and call just once!!
            initComponents();
        }

        public function get shootSignal(): Signal
        {
            return _weaponControl.shootSignal;
        }

        protected function mountComponents(): void
        {
            var weaponComponent: IWeaponComponent;

            if (_shootingVO.componentSlots)
            {
                var weaponSlot: ComponentSlot;

                for (var i: int = 0; i < _shootingVO.componentSlots.length; i++)
                {
                    weaponSlot = _shootingVO.componentSlots[i];
                    if (weaponSlot.isComponentType(ComponentType.GUNS))
                    {
                        weaponComponent = createWeapon(weaponSlot);
                        addComponent(weaponComponent);
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
        protected function createWeapon(aWeaponVO: ComponentSlot): IWeaponComponent
        {
            return null;
        }

        public function get targetProvider(): ITargetProvider
        {
            return _targetProvider;
        }
    }
}
