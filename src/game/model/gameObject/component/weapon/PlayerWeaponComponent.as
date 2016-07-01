package game.model.gameObject.component.weapon
{
    import game.model.GameObject;
    import game.model.gameObject.IGameObjectFactory;
    import game.model.gameObject.component.ComponentType;
    import game.model.gameObject.component.generator.IGeneratorComponent;

    public class PlayerWeaponComponent extends WeaponComponent
    {
        public static const MIN_POWER: uint = 0;

        private var playerWeaponModel: PlayerWeaponModel;
        private var _generator: IGeneratorComponent;

        public function PlayerWeaponComponent(aWeaponModel: WeaponModel, aGameObjectFactory: IGameObjectFactory, aX: Number = 0, aY: Number = 0, _aPower: uint = MIN_POWER)
        {
            super(aWeaponModel, aGameObjectFactory, aX, aY);

            playerWeaponModel = PlayerWeaponModel(aWeaponModel);
            playerWeaponModel.setPower(_aPower);
        }

        public function get displayedPower(): uint
        {
            return playerWeaponModel.power + 1;
        }

        public function get power(): uint
        {
            return playerWeaponModel.power;
        }

        override public function init(aGameObject: GameObject): void
        {
            _generator = IGeneratorComponent(aGameObject.getComponent(IGeneratorComponent));

            super.init(aGameObject);
        }

        public function addPower(): void
        {
            playerWeaponModel.setPower(playerWeaponModel.power + 1);
        }

        public function onDeath(): void
        {
            playerWeaponModel.setPower(Math.max(Math.floor(playerWeaponModel.power / 2), MIN_POWER));
            endShoot();
        }

        override public function shoot(aX: Number, aY: Number): void
        {
            if (_generator.percentLeft > 30 || weaponModel.componentType == ComponentType.MAIN_GUN)
            {
                if (_generator.deplete(playerWeaponModel.energyCost))
                    super.shoot(aX, aY);
            }
        }
    }
}