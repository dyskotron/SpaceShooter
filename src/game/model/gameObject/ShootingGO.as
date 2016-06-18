package game.model.gameObject
{
    import game.model.gameObject.components.collider.IColliderComponent;
    import game.model.gameObject.components.control.WeaponControlComponent;
    import game.model.gameObject.components.fsm.ITargetProvider;
    import game.model.gameObject.components.health.IHealthComponent;
    import game.model.gameObject.vo.ShootingVO;

    import org.osflash.signals.Signal;

    public class ShootingGO extends HittableGO
    {
        private var _targetProvider: ITargetProvider;

        protected var _weaponControl: WeaponControlComponent;

        /**
         * Base class for all game objects which are able to shoot
         * @param aShootingVO
         * @param aTargetProvider
         * @param aX
         * @param aY
         */
        public function ShootingGO(aShootingVO: ShootingVO, aTargetProvider: ITargetProvider, aX: Number, aY: Number)
        {
            super(aShootingVO, aX, aY);

            _targetProvider = aTargetProvider;
        }

        override protected function createHealthComponent(aInitialHP: int): IHealthComponent
        {
            return null;
        }

        override protected function createCollider(): IColliderComponent
        {
            return null;
        }

        public function get shootSignal(): Signal
        {
            return _weaponControl.shootSignal;
        }

        public function get targetProvider(): ITargetProvider
        {
            return _targetProvider;
        }
    }
}
