package game.model.gameObject.def
{
    import game.model.gameObject.constants.BulletID;
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
                case BulletID.LASER:
                    return new BulletVO(aBulletType, 15, 4, 10);
                    break;
                case BulletID.PLASMA_1:
                    return new BulletVO(aBulletType, 8, 4, 10);
                    break;
                case BulletID.PLASMA_2:
                    return new BulletVO(aBulletType, 15, 6, 10);
                    break;
                case BulletID.PLASMA_3:
                    return new BulletVO(aBulletType, 30, 8, 10);
                    break;
                case BulletID.ELECTRIC_1:
                    return new BulletVO(aBulletType, 10, 4, 10);
                    break;
                case BulletID.ELECTRIC_2:
                    return new BulletVO(aBulletType, 20, 4, 10);
                    break;
                default:
                    throw new Error("No bullet for bullet type" + aBulletType);
            }


            return null;
        }
    }
}
