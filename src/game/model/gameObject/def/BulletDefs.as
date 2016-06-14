package game.model.gameObject.def
{
    import game.model.gameObject.components.weapon.enums.BulletAim;
    import game.model.gameObject.constants.BulletID;
    import game.model.gameObject.constants.BulletMode;
    import game.model.gameObject.vo.BulletVO;

    public class BulletDefs implements IBulletDefs
    {
        public static const LASER_DMG_TO_COST: Number = 1;
        public static const PLASMA_DMG_TO_COST: Number = 2;
        public static const ELECTRIC_DMG_TO_COST: Number = 1; // should be 3 with bullet fx 6x return power
        public static const AOE_DMG_TO_COST: Number = 5;

        public function getBulletVO(aBulletType: uint): BulletVO
        {
            switch (aBulletType)
            {
                case BulletID.LASER_1:
                    return new BulletVO(aBulletType, BulletMode.ONE_SHOT, BulletAim.NONE, 15, 4, 4, LASER_DMG_TO_COST);
                    break;
                case BulletID.LASER_2:
                    return new BulletVO(aBulletType, BulletMode.ONE_SHOT, BulletAim.NONE, 15, 4, 4, LASER_DMG_TO_COST);
                    break;
                case BulletID.LASER_3:
                    return new BulletVO(aBulletType, BulletMode.ONE_SHOT, BulletAim.NONE, 15, 4, 4, LASER_DMG_TO_COST);
                    break;
                case BulletID.LASER_4:
                    return new BulletVO(aBulletType, BulletMode.ONE_SHOT, BulletAim.NONE, 15, 4, 4, LASER_DMG_TO_COST);
                    break;

                case BulletID.PLASMA_1:
                    return new BulletVO(aBulletType, BulletMode.EACH_ONCE, BulletAim.NONE, 8, 4, 4, PLASMA_DMG_TO_COST);
                    break;
                case BulletID.PLASMA_2:
                    return new BulletVO(aBulletType, BulletMode.EACH_ONCE, BulletAim.NONE, 8, 4, 4, PLASMA_DMG_TO_COST);
                    break;
                case BulletID.PLASMA_3:
                    return new BulletVO(aBulletType, BulletMode.EACH_ONCE, BulletAim.NONE, 15, 6, 4, PLASMA_DMG_TO_COST);
                    break;
                case BulletID.PLASMA_4:
                    return new BulletVO(aBulletType, BulletMode.EACH_ONCE, BulletAim.NONE, 30, 8, 4, PLASMA_DMG_TO_COST);
                    break;

                case BulletID.ELECTRIC_1:
                    return new BulletVO(aBulletType, BulletMode.ONE_SHOT, BulletAim.NONE, 10, 4, 4, ELECTRIC_DMG_TO_COST);
                    break;
                case BulletID.ELECTRIC_2:
                    return new BulletVO(aBulletType, BulletMode.ONE_SHOT, BulletAim.NONE, 20, 4, 4, ELECTRIC_DMG_TO_COST);
                    break;

                case BulletID.ROCKET_1:
                    return new BulletVO(aBulletType, BulletMode.AOE, BulletAim.ROUGH, 150, 50, 80, AOE_DMG_TO_COST, 200);
                    break;

                default:
                    throw new Error("No bullet for bullet type" + aBulletType);
            }


            return null;
        }
    }
}
