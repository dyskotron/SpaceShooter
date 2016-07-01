package game.model.gameObject.def
{
    import flash.utils.Dictionary;

    import game.model.gameObject.component.fsm.TargetType;
    import game.model.gameObject.component.weapon.enums.AutoAimMode;
    import game.model.gameObject.constants.BulletID;
    import game.model.gameObject.constants.BulletMode;
    import game.model.gameObject.vo.AutoAimVO;
    import game.model.gameObject.vo.BulletVO;

    public class BulletDefs implements IBulletDefs
    {
        public static const LASER_DMG_TO_COST: Number = 1;
        public static const PLASMA_DMG_TO_COST: Number = 2;
        public static const ELECTRIC_DMG_TO_COST: Number = 1; // should be 3 with bullet fx 6x return power
        public static const AOE_DMG_TO_COST: Number = 5;

        private var _bulletVos: Dictionary;

        public function BulletDefs(): void
        {
            _bulletVos = new Dictionary();

            _bulletVos[BulletID.LASER_1] = new BulletVO(BulletID.LASER_1, BulletMode.ONE_SHOT, null, 15, 4, 4, LASER_DMG_TO_COST);
            _bulletVos[BulletID.LASER_2] = new BulletVO(BulletID.LASER_2, BulletMode.ONE_SHOT, null, 15, 4, 4, LASER_DMG_TO_COST);
            _bulletVos[BulletID.LASER_3] = new BulletVO(BulletID.LASER_3, BulletMode.ONE_SHOT, null, 15, 4, 4, LASER_DMG_TO_COST);
            _bulletVos[BulletID.LASER_4] = new BulletVO(BulletID.LASER_4, BulletMode.ONE_SHOT, null, 15, 4, 4, LASER_DMG_TO_COST);

            _bulletVos[BulletID.PLASMA_1] = new BulletVO(BulletID.PLASMA_1, BulletMode.EACH_ONCE, null, 8, 4, 4, PLASMA_DMG_TO_COST);
            _bulletVos[BulletID.PLASMA_2] = new BulletVO(BulletID.PLASMA_2, BulletMode.EACH_ONCE, null, 8, 4, 4, PLASMA_DMG_TO_COST);
            _bulletVos[BulletID.PLASMA_3] = new BulletVO(BulletID.PLASMA_3, BulletMode.EACH_ONCE, null, 15, 6, 4, PLASMA_DMG_TO_COST);
            _bulletVos[BulletID.PLASMA_4] = new BulletVO(BulletID.PLASMA_4, BulletMode.EACH_ONCE, null, 30, 8, 4, PLASMA_DMG_TO_COST);

            _bulletVos[BulletID.ELECTRIC_1] = new BulletVO(BulletID.ELECTRIC_1, BulletMode.ONE_SHOT, null, 10, 4, 4, ELECTRIC_DMG_TO_COST);
            _bulletVos[BulletID.ELECTRIC_2] = new BulletVO(BulletID.ELECTRIC_2, BulletMode.ONE_SHOT, null, 20, 4, 4, ELECTRIC_DMG_TO_COST);

            var autoAimVO: AutoAimVO = new AutoAimVO(TargetType.EASIEST, AutoAimMode.ON_UPDATE, Math.PI / 4, Math.PI);
            _bulletVos[BulletID.ROCKET_1] = new BulletVO(BulletID.ROCKET_1, BulletMode.AOE, autoAimVO, 150, 50, 80, AOE_DMG_TO_COST, 200);
        }

        public function getBulletVO(aBulletType: uint): BulletVO
        {
            if (!_bulletVos[aBulletType])
                throw new Error("unknown bullet type");

            return _bulletVos[aBulletType];
        }
    }
}
