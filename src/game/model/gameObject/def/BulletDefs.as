package game.model.gameObject.def
{
    import game.model.gameObject.constants.BulletID;
    import game.model.gameObject.constants.BulletMode;
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
                case BulletID.LASER_1:
                    return new BulletVO(aBulletType, BulletMode.ONE_SHOT, 15, 4, 4);
                    break;
                case BulletID.LASER_2:
                    return new BulletVO(aBulletType, BulletMode.ONE_SHOT, 15, 4, 4);
                    break;
                case BulletID.LASER_3:
                    return new BulletVO(aBulletType, BulletMode.ONE_SHOT, 15, 4, 4);
                    break;
                case BulletID.LASER_4:
                    return new BulletVO(aBulletType, BulletMode.ONE_SHOT, 15, 4, 4);
                    break;

                case BulletID.PLASMA_1:
                    return new BulletVO(aBulletType, BulletMode.EACH_ONCE, 8, 4, 4);
                    break;
                case BulletID.PLASMA_2:
                    return new BulletVO(aBulletType, BulletMode.EACH_ONCE, 8, 4, 4);
                    break;
                case BulletID.PLASMA_3:
                    return new BulletVO(aBulletType, BulletMode.EACH_ONCE, 15, 6, 4);
                    break;
                case BulletID.PLASMA_4:
                    return new BulletVO(aBulletType, BulletMode.EACH_ONCE, 30, 8, 4);
                    break;

                case BulletID.ELECTRIC_1:
                    return new BulletVO(aBulletType, BulletMode.ONE_SHOT, 10, 4, 4);
                    break;
                case BulletID.ELECTRIC_2:
                    return new BulletVO(aBulletType, BulletMode.ONE_SHOT, 20, 4, 4);
                    break;

                case BulletID.ROCKET_1:
                    return new BulletVO(aBulletType, BulletMode.AOE, 400, 50, 80, 200);
                    break;

                default:
                    throw new Error("No bullet for bullet type" + aBulletType);
            }


            return null;
        }
    }
}
