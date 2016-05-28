package game.model.gameObject.def
{
    import game.model.gameObject.constants.BulletType;
    import game.model.gameObject.vo.BulletVO;

    public class BulletDefs implements IBulletDefs
    {
        public function BulletDefs()
        {
        }

        public function getBulletVO(aBulletType: uint): BulletVO
        {
            switch (aBulletType)
            {
                case BulletType.LASER:
                    return new BulletVO(aBulletType, 15, 4, 10);
                    break;
                case BulletType.ELECTRIC:
                    break;
                case BulletType.PLASMA:
                    break;
                case BulletType.FREEZE:
                    break;
                default:
                    throw new Error("No bullet for bullet type" + aBulletType);
            }


            return null;
        }
    }
}
