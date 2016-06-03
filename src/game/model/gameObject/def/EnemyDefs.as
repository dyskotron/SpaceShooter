package game.model.gameObject.def
{
    import common.model.TextureProvider;

    import game.model.gameObject.constants.BulletID;
    import game.model.gameObject.constants.EnemyType;
    import game.model.gameObject.vo.EnemyVO;
    import game.model.weapon.ComponentSlot;
    import game.model.weapon.IWeaponDefs;
    import game.model.weapon.enums.ComponentType;
    import game.model.weapon.enums.EnemyWeaponID;

    import org.robotlegs.mvcs.Actor;

    import starling.textures.Texture;

    public class EnemyDefs extends Actor implements IEnemyDefs
    {
        private var _enemyDefByID: Vector.<EnemyVO>;
        private var _weaponDefs: IWeaponDefs;

        public function EnemyDefs(aTextureProvider: TextureProvider, aWeaponDefs: IWeaponDefs)
        {
            _enemyDefByID = new Vector.<EnemyVO>;
            _weaponDefs = aWeaponDefs;

            var enemyType: uint;
            var texture: Texture;
            var speed: uint;
            var weapons: Vector.<ComponentSlot>;
            var hp: int;
            var width: Number;
            var height: Number;

            //FIGHTERS
            texture = aTextureProvider.getEnemyTexture(EnemyType.FIGHTER_1);

            enemyType = EnemyType.FIGHTER_1;
            speed = 200;
            weapons = getWeaponSlots(EnemyWeaponID.LASER, 4000, BulletID.LASER);
            width = texture.width * 0.6;
            height = texture.height * 0.6;
            hp = 30;
            _enemyDefByID[enemyType] = new EnemyVO(enemyType, speed, weapons, hp, width, height);

            enemyType = EnemyType.FIGHTER_2;
            weapons = getWeaponSlots(EnemyWeaponID.LASER, 3000, BulletID.LASER);
            width = texture.width * 0.65;
            height = texture.height * 0.65;
            hp = 50;
            _enemyDefByID[enemyType] = new EnemyVO(enemyType, speed, weapons, hp, width, height);

            enemyType = EnemyType.FIGHTER_3;
            weapons = getWeaponSlots(EnemyWeaponID.LASER, 2000, BulletID.LASER);
            width = texture.width * 0.7;
            height = texture.height * 0.7;
            hp = 80;
            _enemyDefByID[enemyType] = new EnemyVO(enemyType, speed, weapons, hp, width, height);

            enemyType = EnemyType.FIGHTER_4;
            weapons = getWeaponSlots(EnemyWeaponID.LASER, 1200, BulletID.LASER);
            width = texture.width * 0.75;
            height = texture.height * 0.75;
            hp = 100;
            _enemyDefByID[enemyType] = new EnemyVO(enemyType, speed, weapons, hp, width, height);

            //KAMIKAZE
            aTextureProvider.getEnemyTexture(EnemyType.KAMIKAZE_1);

            enemyType = EnemyType.KAMIKAZE_1;
            speed = 200;
            weapons = null;
            width = texture.width * 0.4;
            height = texture.height * 0.4;
            hp = 40;
            _enemyDefByID[enemyType] = new EnemyVO(enemyType, speed, weapons, hp, width, height);

            enemyType = EnemyType.KAMIKAZE_2;
            weapons = null;
            width = texture.width * 0.5;
            height = texture.height * 0.5;
            hp = 60;
            _enemyDefByID[enemyType] = new EnemyVO(enemyType, speed, weapons, hp, width, height);

            //WOBBLY
            aTextureProvider.getEnemyTexture(EnemyType.WOBBLY_1);

            enemyType = EnemyType.WOBBLY_1;
            speed = 250;
            weapons = null;
            width = texture.width * 0.6;
            height = texture.height * 0.6;
            hp = 40;
            _enemyDefByID[enemyType] = new EnemyVO(enemyType, speed, weapons, hp, width, height);

            enemyType = EnemyType.WOBBLY_2;
            weapons = null;
            width = texture.width * 0.7;
            height = texture.height * 0.7;
            hp = 60;
            _enemyDefByID[enemyType] = new EnemyVO(enemyType, speed, weapons, hp, width, height);

        }

        public function getEnemyVO(aEnemyType: uint): EnemyVO
        {
            return _enemyDefByID[aEnemyType];
        }

        private function getWeaponSlots(aWeaponID: uint, aShootInterval: uint, bulletType: uint): Vector.<ComponentSlot>
        {
            var weaponSlots: Vector.<ComponentSlot> = new Vector.<ComponentSlot>();
            weaponSlots.push(new ComponentSlot(ComponentType.MAIN_GUN, 0, 0, _weaponDefs.getEnemyWeaponModel(aWeaponID, aShootInterval, bulletType)));
            return weaponSlots;
        }
    }
}
