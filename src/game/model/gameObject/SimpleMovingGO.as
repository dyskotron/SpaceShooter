package game.model.gameObject
{
    import game.model.*;
    import game.model.gameObject.components.movement.MovementParamsComponent;
    import game.model.gameObject.vo.GameObjectVO;

    public class SimpleMovingGO extends GameObject
    {
        protected var movementParams: MovementParamsComponent;

        public function SimpleMovingGO(aGameObjectVO: GameObjectVO, aX: Number, aY: Number, aSpeed: Number = 0, aAngle: Number = 0)
        {
            super(aGameObjectVO, aX, aY);

            movementParams = new MovementParamsComponent(aSpeed);
            movementParams.speedX = aSpeed * Math.sin(aAngle);
            movementParams.speedY = aSpeed * Math.cos(aAngle);
            addComponent(movementParams);

        }

        override public function update(aDeltaTime: int): void
        {
            var moveParams: MovementParamsComponent = MovementParamsComponent(getComponent(MovementParamsComponent));

            if (moveParams)
            {
                transform.x += moveParams.speedX * aDeltaTime;
                transform.y += moveParams.speedY * aDeltaTime;
            }
            super.update(aDeltaTime);
        }
    }
}
