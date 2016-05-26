package game.model.gameObject
{
    import game.model.*;
    import game.model.gameObject.vo.GameObjectVO;

    public class SimpleMovingGO extends GameObject
    {
        public function SimpleMovingGO(aGameObjectVO: GameObjectVO, aX: Number, aY: Number, aSpeedX: Number = 0, aSpeedY: Number = 0)
        {
            super(aGameObjectVO, aX, aY, aSpeedX, aSpeedY);
        }

        override public function update(aDeltaTime: int): void
        {
            x += speedX * aDeltaTime;
            y += speedY * aDeltaTime;

            super.update(aDeltaTime);
        }
    }
}
