package game.model.gameObject.vo
{
    public class ObstacleVO extends HittableVO
    {
        public function ObstacleVO(aTypeID: uint, aInitialHP: int, aWidth: Number, aHeight: Number)
        {
            super(aTypeID, aInitialHP, aWidth, aHeight);
        }
    }
}
