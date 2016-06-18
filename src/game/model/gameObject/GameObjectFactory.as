package game.model.gameObject
{
    import game.model.GameObject;
    import game.model.gameObject.components.ComponentType;
    import game.model.gameObject.components.IComponent;
    import game.model.gameObject.components.collider.SquareColliderComponent;
    import game.model.gameObject.components.control.PlayerControlComponent;
    import game.model.gameObject.components.control.WeaponControlComponent;
    import game.model.gameObject.components.fsm.GameObjectFSM;
    import game.model.gameObject.components.fsm.ITarget;
    import game.model.gameObject.components.fsm.ITargetProvider;
    import game.model.gameObject.components.generator.BatteryModel;
    import game.model.gameObject.components.generator.EnergyComponent;
    import game.model.gameObject.components.generator.GeneratorModel;
    import game.model.gameObject.components.health.HealthComponent;
    import game.model.gameObject.components.health.PlayerHealthComponent;
    import game.model.gameObject.components.identity.IdentityComponent;
    import game.model.gameObject.components.movement.MoveLinearY;
    import game.model.gameObject.components.movement.MoveParamsComponent;
    import game.model.gameObject.components.weapon.ComponentSlot;
    import game.model.gameObject.components.weapon.EnemyWeaponComponent;
    import game.model.gameObject.components.weapon.IWeaponComponent;
    import game.model.gameObject.components.weapon.PlayerWeaponComponent;
    import game.model.gameObject.components.weapon.WeaponModel;
    import game.model.gameObject.def.IComponentDefs;
    import game.model.gameObject.def.IPlayerShipDefs;
    import game.model.gameObject.vo.BehaviorVO;
    import game.model.gameObject.vo.BonusVO;
    import game.model.gameObject.vo.EnemyVO;
    import game.model.gameObject.vo.PlayerShipVO;
    import game.model.playerModel.PlayerShipBuildVO;

    public class GameObjectFactory implements IGameObjectFactory
    {
        [Inject]
        public var componentDefs: IComponentDefs;

        [Inject]
        public var playerShipDefs: IPlayerShipDefs;

        public function GameObjectFactory()
        {
        }


        public function createPlayerShipGO(aPlayerID: uint, aShipBuild: PlayerShipBuildVO, aTargetProvider: ITargetProvider): GameObject
        {
            var playerShipVO: PlayerShipVO = playerShipDefs.getPlayerShipVO(aShipBuild);

            //create ship gameobject
            var gameObject: GameObject = new GameObject(playerShipVO, 0, 0);

            //create components and add to ship go
            gameObject.addComponents(getComponentsBySlots(playerShipVO.componentSlots));
            gameObject.addComponent(new WeaponControlComponent(aTargetProvider));
            gameObject.addComponent(new SquareColliderComponent());
            gameObject.addComponent(new PlayerHealthComponent(playerShipVO.initialHP, 3));
            gameObject.addComponent(new PlayerControlComponent());
            gameObject.addComponent(new MoveParamsComponent());
            var identity: IdentityComponent = new IdentityComponent();
            identity.gameObjectGroupSpecificID = aPlayerID;
            identity.gameObjectType = aShipBuild.shipTypeID;

            //set width/height
            gameObject.transform.width = playerShipVO.width;
            gameObject.transform.height = playerShipVO.height;

            return gameObject;
        }

        public function createEnemyShipGO(aEnemyVO: EnemyVO, aBehaviorVO: BehaviorVO, aTargetProvider: ITargetProvider, aX: Number, aY: Number, aTarget: ITarget): GameObject
        {
            var gameObject: GameObject = new GameObject(aEnemyVO, 0, 0);
            var weaponSlot: ComponentSlot;
            if (aEnemyVO.componentSlots)
            {
                for (var i: int = 0; i < aEnemyVO.componentSlots.length; i++)
                {
                    weaponSlot = aEnemyVO.componentSlots[i];
                    if (weaponSlot.isComponentType(ComponentType.GUNS))
                    {
                        gameObject.addComponent(new EnemyWeaponComponent(WeaponModel(weaponSlot.componentModel), weaponSlot.x, weaponSlot.y));
                    }
                }
            }
            gameObject.transform.x = aX;
            gameObject.transform.y = aY;
            gameObject.addComponent(new MoveParamsComponent(aEnemyVO.speed));
            gameObject.addComponent(new GameObjectFSM(aBehaviorVO.states, aTarget));
            gameObject.addComponent(new HealthComponent(aEnemyVO.initialHP));
            gameObject.addComponent(new SquareColliderComponent());
            var _weaponControl: WeaponControlComponent = new WeaponControlComponent(aTargetProvider);
            gameObject.addComponent(_weaponControl);

            _weaponControl.startShoot();

            return gameObject;
        }

        public function createBonusGO(aBonusVO: BonusVO, aX: Number, aY: Number, aSpeedY: Number): GameObject
        {
            var gameObject: GameObject = new GameObject(aBonusVO, 0, 0);
            gameObject.transform.x = aX;
            gameObject.transform.y = aY;

            var movementParams = new MoveParamsComponent(aSpeedY);
            movementParams.speedY = aSpeedY;
            gameObject.addComponent(movementParams);

            gameObject.addComponent(new MoveLinearY());

            return gameObject;
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
