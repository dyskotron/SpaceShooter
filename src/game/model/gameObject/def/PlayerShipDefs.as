package game.model.gameObject.def
{
    import game.model.gameObject.PlayerShipGO;
    import game.model.gameObject.components.ComponentType;
    import game.model.gameObject.components.IComponent;
    import game.model.gameObject.components.collider.SquareColliderComponent;
    import game.model.gameObject.components.control.PlayerControlComponent;
    import game.model.gameObject.components.generator.BatteryModel;
    import game.model.gameObject.components.generator.EnergyComponent;
    import game.model.gameObject.components.generator.GeneratorModel;
    import game.model.gameObject.components.health.PlayerHealthComponent;
    import game.model.gameObject.components.weapon.ComponentSlot;
    import game.model.gameObject.components.weapon.IWeaponComponent;
    import game.model.gameObject.components.weapon.PlayerWeaponComponent;
    import game.model.gameObject.components.weapon.WeaponModel;
    import game.model.gameObject.components.weapon.enums.SlotDirection;
    import game.model.gameObject.constants.PlayerShipType;
    import game.model.gameObject.fsm.ITargetProvider;
    import game.model.gameObject.vo.PlayerShipVO;
    import game.model.playerModel.PlayerShipBuildVO;

    public class PlayerShipDefs implements IPlayerShipDefs
    {
        [Inject]
        public var componentDefs: IComponentDefs;

        public function PlayerShipDefs()
        {

        }

        public function playerGameObjectFactory(aPlayerID: int, aShipBuild: PlayerShipBuildVO, aTargetProvider: ITargetProvider): PlayerShipGO
        {
            var playerShipVO: PlayerShipVO = getPlayerShipVO(aShipBuild);

            //create ship gameobject
            var gameObject: PlayerShipGO = new PlayerShipGO(playerShipVO, aTargetProvider);

            //create weapon components and add to ship go
            gameObject.addComponents(getComponentsBySlots(playerShipVO.componentSlots));
            gameObject.addComponent(new SquareColliderComponent());
            gameObject.addComponent(new PlayerHealthComponent(playerShipVO.initialHP, 3));
            gameObject.addComponent(new PlayerControlComponent());

            //set width/height
            gameObject.transform.width = playerShipVO.width;
            gameObject.transform.height = playerShipVO.height;

            return gameObject;
        }


        public function getPlayerShipVO(aShipBuild: PlayerShipBuildVO): PlayerShipVO
        {
            //get ship from build
            var shipVO: PlayerShipVO = getBaseShip(aShipBuild.shipTypeID);

            //apply build components to given ship
            for (var i: int = 0; i < aShipBuild.componentSlots.length; i++)
            {
                shipVO.addComponent(i, componentDefs.getComponentModel(aShipBuild.componentSlots[i]));
            }
            //create gameObject


            return shipVO;
        }

        private function getBaseShip(aShipTypeID: uint): PlayerShipVO
        {
            var componentSlots: Vector.<ComponentSlot>;
            componentSlots = new Vector.<ComponentSlot>();
            componentSlots.push(new ComponentSlot(ComponentType.MAIN_SLOT, 0, 0, Math.PI, SlotDirection.CENTER));
            componentSlots.push(new ComponentSlot(ComponentType.SECONDARY_SLOT, 0, 0, Math.PI, SlotDirection.CENTER));
            componentSlots.push(new ComponentSlot(ComponentType.SECONDARY_SLOT, -45, 0, Math.PI, SlotDirection.LEFT));
            componentSlots.push(new ComponentSlot(ComponentType.SECONDARY_SLOT, 45, 0, Math.PI, SlotDirection.RIGHT));
            componentSlots.push(new ComponentSlot(ComponentType.SECONDARY_SLOT, -30, 0, Math.PI, SlotDirection.LEFT));
            componentSlots.push(new ComponentSlot(ComponentType.SECONDARY_SLOT, 30, 0, Math.PI, SlotDirection.RIGHT));
            componentSlots.push(new ComponentSlot(ComponentType.SECONDARY_SLOT, -15, 0, 0, SlotDirection.RIGHT));
            componentSlots.push(new ComponentSlot(ComponentType.SECONDARY_SLOT, 15, 0, 0, SlotDirection.LEFT));
            componentSlots.push(new ComponentSlot(ComponentType.CHARGE_GUN, 0, 60));

            return new PlayerShipVO(PlayerShipType.BASIC_SHOOTER, componentSlots, 150, 99, 75);
        }


        protected function getComponentsBySlots(aComponentSlots: Vector.<ComponentSlot>): Vector.<IComponent>
        {
            var components: Vector.<IComponent> = new Vector.<IComponent>();
            var capacity: Number = 0;
            var rechargeSpeed: Number = 0;

            if (aComponentSlots)
            {
                var componentSlot: ComponentSlot;

                for (var i: int = 0; i < aComponentSlots.length; i++)
                {
                    componentSlot = aComponentSlots[i];

                    if (componentSlot.isComponentType(ComponentType.GENERATOR))
                    {
                        rechargeSpeed += GeneratorModel(componentSlot.componentModel).rechargeSpeed;
                    }
                    else if (componentSlot.isComponentType(ComponentType.BATTERY))
                    {
                        capacity += BatteryModel(componentSlot.componentModel).capacity;
                    }
                    else if (componentSlot.isComponentType(ComponentType.GUNS))
                    {
                        components.push(createWeapon(componentSlot));
                    }

                    //add collider and all other shit
                }
            }

            components.push(new EnergyComponent(capacity, rechargeSpeed));

            return components;
        }

        protected function createWeapon(aComponentSlot: ComponentSlot): IWeaponComponent
        {
            var playerWeaponComponent: IWeaponComponent = new PlayerWeaponComponent(WeaponModel(aComponentSlot.componentModel), aComponentSlot.x, aComponentSlot.y);
            return playerWeaponComponent;
        }
    }
}
