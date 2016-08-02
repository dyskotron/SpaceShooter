package game.model.gameObject
{
    import game.model.GameObject;
    import game.model.gameObject.component.ComponentType;
    import game.model.gameObject.component.IComponent;
    import game.model.gameObject.component.collider.OnceSquareColliderComponent;
    import game.model.gameObject.component.collider.SquareColliderComponent;
    import game.model.gameObject.component.control.PlayerControlComponent;
    import game.model.gameObject.component.control.WeaponControlComponent;
    import game.model.gameObject.component.effect.EffectsContainer;
    import game.model.gameObject.component.fsm.FSMComponent;
    import game.model.gameObject.component.fsm.ITarget;
    import game.model.gameObject.component.fsm.ITargetProvider;
    import game.model.gameObject.component.generator.BatteryModel;
    import game.model.gameObject.component.generator.EnergyComponent;
    import game.model.gameObject.component.generator.GeneratorModel;
    import game.model.gameObject.component.health.HealthComponent;
    import game.model.gameObject.component.health.PlayerHealthComponent;
    import game.model.gameObject.component.movement.AutoAimComponent;
    import game.model.gameObject.component.movement.MoveLinearXYRotation;
    import game.model.gameObject.component.movement.MoveLinearY;
    import game.model.gameObject.component.movement.MoveParamsComponent;
    import game.model.gameObject.component.movement.MovePolarComponent;
    import game.model.gameObject.component.weapon.ComponentSlot;
    import game.model.gameObject.component.weapon.EnemyWeaponComponent;
    import game.model.gameObject.component.weapon.IWeaponComponent;
    import game.model.gameObject.component.weapon.PlayerWeaponComponent;
    import game.model.gameObject.component.weapon.WeaponModel;
    import game.model.gameObject.constants.BulletMode;
    import game.model.gameObject.constants.GameObjectGroupID;
    import game.model.gameObject.def.IComponentDefs;
    import game.model.gameObject.def.IPlayerShipDefs;
    import game.model.gameObject.vo.BehaviorVO;
    import game.model.gameObject.vo.BonusVO;
    import game.model.gameObject.vo.BulletVO;
    import game.model.gameObject.vo.EnemyVO;
    import game.model.gameObject.vo.ObstacleVO;
    import game.model.gameObject.vo.PlayerShipVO;
    import game.model.playerModel.PlayerShipBuildVO;

    public class GameObjectFactory implements IGameObjectFactory
    {
        [Inject]
        public var componentDefs: IComponentDefs;

        [Inject]
        public var playerShipDefs: IPlayerShipDefs;

        private var _lastGameObjectID: uint = 0;
        private var _lastEnemyID: uint = 0;
        private var _lastBonusID: uint = 0;
        private var _lastObstacleID: uint = 0;
        private var _lastBulletID: uint = 0;

        public function GameObjectFactory()
        {
        }


        public function createPlayerShipGO(aPlayerID: uint, aShipBuild: PlayerShipBuildVO, aTargetProvider: ITargetProvider): GameObject
        {
            var playerShipVO: PlayerShipVO = playerShipDefs.getPlayerShipVO(aShipBuild);

            //create ship gameobject
            var gameObject: GameObject = new GameObject(getIdentity(GameObjectGroupID.PLAYER_SHIP, aShipBuild.shipTypeID, aPlayerID), 0, 0, playerShipVO.width, playerShipVO.height);

            //create components and add to ship go
            gameObject.addComponents(getComponentsBySlots(playerShipVO.componentSlots));
            gameObject.addComponent(new WeaponControlComponent(aTargetProvider));
            gameObject.addComponent(new SquareColliderComponent());
            gameObject.addComponent(new PlayerHealthComponent(playerShipVO.initialHP, 3));
            gameObject.addComponent(new PlayerControlComponent());
            gameObject.addComponent(new MoveParamsComponent());

            //set width/height
            gameObject.transform.width = playerShipVO.width;
            gameObject.transform.height = playerShipVO.height;

            gameObject.initComponents();
            return gameObject;
        }

        public function createEnemyShipGO(aEnemyVO: EnemyVO, aBehaviorVO: BehaviorVO, aTargetProvider: ITargetProvider, aTarget: ITarget): GameObject
        {
            var gameObject: GameObject = new GameObject(getIdentity(GameObjectGroupID.ENEMY, aEnemyVO.concreteTypeID, _lastEnemyID++), 0, 0, aEnemyVO.width, aEnemyVO.height);
            var weaponSlot: ComponentSlot;
            if (aEnemyVO.componentSlots)
            {
                for (var i: int = 0; i < aEnemyVO.componentSlots.length; i++)
                {
                    weaponSlot = aEnemyVO.componentSlots[i];
                    if (weaponSlot.isComponentType(ComponentType.GUNS))
                    {
                        gameObject.addComponent(new EnemyWeaponComponent(WeaponModel(weaponSlot.componentModel), this, weaponSlot.x, weaponSlot.y));
                    }
                }
            }

            gameObject.addComponent(new MoveParamsComponent(aEnemyVO.speed));
            gameObject.addComponent(new FSMComponent(aBehaviorVO.states, aTarget));
            gameObject.addComponent(new HealthComponent(aEnemyVO.initialHP));
            gameObject.addComponent(new SquareColliderComponent());
            gameObject.addComponent(new WeaponControlComponent(aTargetProvider));
            gameObject.addComponent(new EffectsContainer());

            gameObject.initComponents();

            return gameObject;
        }

        public function createBonusGO(aBonusVO: BonusVO, aSpeedY: Number): GameObject
        {
            var gameObject: GameObject = new GameObject(getIdentity(GameObjectGroupID.BONUS, aBonusVO.concreteTypeID, _lastBonusID++), 0, 0, aBonusVO.width, aBonusVO.height);
            gameObject.addComponent(new MoveLinearY(aSpeedY));
            gameObject.addComponent(new SquareColliderComponent());

            gameObject.initComponents();
            return gameObject;
        }

        public function createObstacleGO(aObstacleVO: ObstacleVO, aSpeedX: Number, aSpeedY: Number, aRotation: Number): GameObject
        {
            var gameObject: GameObject = new GameObject(getIdentity(GameObjectGroupID.OBSTACLE, aObstacleVO.concreteTypeID, _lastObstacleID++), 0, 0, aObstacleVO.width, aObstacleVO.height);
            gameObject.addComponent(new MoveLinearXYRotation(aSpeedX, aSpeedY, aRotation));
            gameObject.addComponent(new HealthComponent(aObstacleVO.initialHP));
            gameObject.addComponent(new SquareColliderComponent());

            gameObject.initComponents();
            return gameObject;
        }

        public function createBulletGO(aBulletVO: BulletVO, aOwner: GameObjectIdentity, aSpeed: Number, aAngle: Number, aTargetProvider: ITargetProvider): GameObject
        {
            var gameObject: GameObject = new GameObject(getIdentity(GameObjectGroupID.BULLET, aBulletVO.concreteTypeID, _lastBulletID++, aOwner), 0, 0, aBulletVO.width, aBulletVO.height);

            gameObject.addComponent(new MoveParamsComponent(aSpeed));
            if (aBulletVO.autoAim)
                gameObject.addComponent(new AutoAimComponent(aTargetProvider, aBulletVO.autoAim, aAngle));
            else
                gameObject.addComponent(new MovePolarComponent(aSpeed, aAngle));

            if (aBulletVO.mode == BulletMode.EACH_ONCE)
                gameObject.addComponent(new OnceSquareColliderComponent);
            else
                gameObject.addComponent(new SquareColliderComponent);


            gameObject.initComponents();
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
                }
            }

            components.push(new EnergyComponent(capacity, rechargeSpeed));

            return components;
        }

        protected function createWeapon(aComponentSlot: ComponentSlot): IWeaponComponent
        {
            var playerWeaponComponent: IWeaponComponent = new PlayerWeaponComponent(WeaponModel(aComponentSlot.componentModel), this, aComponentSlot.x, aComponentSlot.y);
            return playerWeaponComponent;
        }

        private function getIdentity(aGameObjectGroup: uint, aConcreteTypeID: uint, aConcreteID: uint, aOwner: GameObjectIdentity = null): GameObjectIdentity
        {
            return new GameObjectIdentity(_lastGameObjectID++, aGameObjectGroup, aConcreteTypeID, aConcreteID, aOwner);
        }

    }
}
