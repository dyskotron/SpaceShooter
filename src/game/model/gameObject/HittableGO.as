package game.model.gameObject
{
    import game.model.*;
    import game.model.gameObject.components.health.HealthComponent;
    import game.model.gameObject.components.health.IHealthComponent;
    import game.model.gameObject.vo.HittableVO;

    public class HittableGO extends GameObject
    {
        private var _hittableVO: HittableVO;
        private var _healthComponent: IHealthComponent;

        public function HittableGO(aHittableVO: HittableVO, aX: Number, aY: Number, aSpeedX: Number = 0, aSpeedY: Number = 0)
        {
            super(aHittableVO, aX, aY, aSpeedX, aSpeedY);

            _hittableVO = aHittableVO;
            _healthComponent = createHealthComponent(aHittableVO.initialHP);
            _healthComponent.init(this);
        }

        public function get hittableVO(): HittableVO
        {
            return _hittableVO;
        }

        public function get healthComponent(): IHealthComponent
        {
            return _healthComponent;
        }

        protected function createHealthComponent(aInitialHP: int): IHealthComponent
        {
            return new HealthComponent(aInitialHP);
        }
    }
}
