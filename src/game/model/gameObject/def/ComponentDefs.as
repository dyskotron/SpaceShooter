package game.model.gameObject.def
{
    import game.model.gameObject.components.ComponentType;
    import game.model.gameObject.components.generator.BatteryID;
    import game.model.gameObject.components.generator.BatteryModel;
    import game.model.gameObject.components.generator.GeneratorID;
    import game.model.gameObject.components.generator.GeneratorModel;
    import game.model.gameObject.components.weapon.ComponentModel;
    import game.model.gameObject.components.weapon.IWeaponDefs;
    import game.model.playerModel.BuildComponentSlotVO;

    public class ComponentDefs implements IComponentDefs
    {
        [Inject]
        public var weaponDef: IWeaponDefs;

        public function getComponentModel(aBuildComponentSlotVO: BuildComponentSlotVO): ComponentModel
        {
            var componentModel: ComponentModel;

            switch (aBuildComponentSlotVO.componentType)
            {
                case ComponentType.MAIN_GUN:
                    componentModel = weaponDef.getMainWeaponModel(aBuildComponentSlotVO.componentID);
                    break;
                case ComponentType.SECONDARY_GUN:
                    componentModel = weaponDef.getSeconaryWeaponModel(aBuildComponentSlotVO.componentID);
                    break;
                case ComponentType.GENERATOR:
                    componentModel = getGeneratorModel(aBuildComponentSlotVO.componentID);
                    break;
                case ComponentType.BATTERY:
                    componentModel = getBatteryModel(aBuildComponentSlotVO.componentID);
                    break;
                default:
                    throw new Error("No component for component type ID: " + aBuildComponentSlotVO.componentType);

            }

            return componentModel;
        }


        private function getGeneratorModel(aGeneratorID: uint): GeneratorModel
        {
            var generatorModel: GeneratorModel;

            switch (aGeneratorID)
            {
                case GeneratorID.BASIC:
                    generatorModel = new GeneratorModel(0, 500);
                    break;
                default:
                    throw new Error("No generator for generator ID: " + aGeneratorID);

            }

            return generatorModel;
        }

        private function getBatteryModel(aBatteryID: uint): BatteryModel
        {
            var batteryModel: BatteryModel;

            switch (aBatteryID)
            {
                case BatteryID.BASIC:
                    batteryModel = new BatteryModel(0, 1000);
                    break;
                default:
                    throw new Error("No battery for component ID: " + aBatteryID);

            }

            return batteryModel;
        }
    }
}
