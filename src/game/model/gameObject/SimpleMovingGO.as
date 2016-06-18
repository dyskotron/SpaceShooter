package game.model.gameObject
{
    import game.model.*;
    import game.model.gameObject.components.movement.MoveParamsComponent;
    import game.model.gameObject.vo.GameObjectVO;

    public class SimpleMovingGO extends GameObject
    {
        protected var movementParams: MoveParamsComponent;

        public function SimpleMovingGO(aGameObjectVO: GameObjectVO, aX: Number, aY: Number, aSpeed: Number = 0, aAngle: Number = 0)
        {
            super(aGameObjectVO, aX, aY);

            if (!hasComponent(MoveParamsComponent))
            {
                movementParams = new MoveParamsComponent(aSpeed);
                movementParams.speedX = aSpeed * Math.sin(aAngle);
                movementParams.speedY = aSpeed * Math.cos(aAngle);
                addComponent(movementParams);
            }

        }

        override public function update(aDeltaTime: int): void
        {
            var moveParams: MoveParamsComponent = MoveParamsComponent(getComponent(MoveParamsComponent));

            if (moveParams)
            {
                transform.x += moveParams.speedX * aDeltaTime;
                transform.y += moveParams.speedY * aDeltaTime;
            }
            super.update(aDeltaTime);
        }
    }
}
