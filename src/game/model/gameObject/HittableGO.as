package game.model.gameObject
{
    import game.model.*;
    import game.model.gameObject.components.health.HealthComponent;
    import game.model.gameObject.components.health.IHealthComponent;
    import game.model.gameObject.vo.HittableVO;

    public class HittableGO extends GameObject
    {
        private var _hittableVO: HittableVO;

        public function HittableGO(aHittableVO: HittableVO, aX: Number, aY: Number)
        {
            super(aHittableVO, aX, aY);

            _hittableVO = aHittableVO;
            var healthComponent: IHealthComponent = createHealthComponent(aHittableVO.initialHP);
            if (healthComponent)
                addComponent(healthComponent);

            //TODO unify with guns and call just once!!
            initComponents();
        }

        protected function createHealthComponent(aInitialHP: int): IHealthComponent
        {
            return new HealthComponent(aInitialHP);
        }
    }
}
