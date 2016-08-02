package game.controller
{
    import common.controller.fsm.*;
    import common.model.TextureProvider;
    import common.model.consts.Platform;

    import flash.ui.Mouse;

    import game.controller.playerControl.ITouchController;
    import game.controller.playerControl.KeyController;
    import game.controller.playerControl.TouchController;
    import game.controller.playerControl.TwoFingersTouchController;
    import game.model.GameModel;
    import game.model.IGameModel;
    import game.model.ILevelProvider;
    import game.model.SerialLevelGenerator;
    import game.model.gameObject.GameObjectFactory;
    import game.model.gameObject.IGameObjectFactory;
    import game.model.gameObject.component.effect.EffectActionProcessor;
    import game.model.gameObject.component.effect.IEffectActionProcessor;
    import game.model.gameObject.component.weapon.IWeaponDefs;
    import game.model.gameObject.component.weapon.WeaponDefs;
    import game.model.gameObject.def.BehaviorFactory;
    import game.model.gameObject.def.BulletDefs;
    import game.model.gameObject.def.ComponentDefs;
    import game.model.gameObject.def.EffectDefs;
    import game.model.gameObject.def.EffectFactory;
    import game.model.gameObject.def.EnemyDefs;
    import game.model.gameObject.def.IBehaviorFactory;
    import game.model.gameObject.def.IBulletDefs;
    import game.model.gameObject.def.IComponentDefs;
    import game.model.gameObject.def.IEffectDefs;
    import game.model.gameObject.def.IEffectFactory;
    import game.model.gameObject.def.IEnemyDefs;
    import game.model.gameObject.def.IObstacleDefs;
    import game.model.gameObject.def.IPlayerShipDefs;
    import game.model.gameObject.def.ObstacleDefs;
    import game.model.gameObject.def.PlayerShipDefs;
    import game.view.DebugGameMediator;
    import game.view.DebugGameView;
    import game.view.GameMediator;
    import game.view.GameView;
    import game.view.GuiMediator;
    import game.view.GuiView;
    import game.view.ResultsMediator;
    import game.view.ResultsView;

    import main.controller.SceneReadySignal;
    import main.controller.SceneReadyVO;
    import main.controller.SwitchSceneSignal;
    import main.controller.SwitchSceneVO;
    import main.view.SceneID;

    public class GameState extends AppState
    {
        [Inject]
        public var switchSceneSignal: SwitchSceneSignal;

        [Inject]
        public var sceneReadySignal: SceneReadySignal;

        [Inject]
        public var gameLoopDispatcher: GameLoopDispatcher;

        [Inject]
        public var physicsUpdateSignal: PhysicsUpdateSignal;

        [Inject]
        public var viewUpdateSignal: ViewUpdateSignal;

        private var gameModel: IGameModel;

        public function GameState()
        {

        }

        override public function start(): void
        {
            gameLoopDispatcher.start();
        }

        override public function transitionIn(): void
        {
            //singletons & values
            injector.mapSingleton(GameEndSignal);

            injector.mapSingletonOf(IBulletDefs, BulletDefs);
            injector.mapSingletonOf(IEnemyDefs, EnemyDefs);
            injector.mapSingletonOf(IComponentDefs, ComponentDefs);
            injector.mapSingletonOf(IPlayerShipDefs, PlayerShipDefs);
            injector.mapSingletonOf(IObstacleDefs, ObstacleDefs);
            injector.mapSingletonOf(IBehaviorFactory, BehaviorFactory);
            injector.mapSingletonOf(IEffectFactory, EffectFactory);
            injector.mapSingletonOf(IEffectDefs, EffectDefs);
            injector.mapSingletonOf(IBulletDefs, BulletDefs);
            injector.mapSingletonOf(IWeaponDefs, WeaponDefs);
            injector.mapSingletonOf(IEffectActionProcessor, EffectActionProcessor);
            injector.mapSingletonOf(IGameObjectFactory, GameObjectFactory);

            injector.mapSingleton(TextureProvider);


            if (CONFIG::platform == Platform.MOBILE)
                injector.mapSingletonOf(ITouchController, TwoFingersTouchController);
            else
                injector.mapSingletonOf(ITouchController, TouchController);

            injector.mapSingleton(KeyController);
            injector.mapSingletonOf(ILevelProvider, SerialLevelGenerator);

            //game model
            gameModel = new GameModel();
            injector.injectInto(gameModel);
            gameModel.init();
            injector.mapValue(IGameModel, gameModel);

            //views
            mediatorMap.mapView(GameView, GameMediator);
            mediatorMap.mapView(GuiView, GuiMediator);
            mediatorMap.mapView(ResultsView, ResultsMediator);

            CONFIG::debug {
                mediatorMap.mapView(DebugGameView, DebugGameMediator);
            }

            //change scene
            sceneReadySignal.add(handleSceneReady);
            switchSceneSignal.dispatch(new SwitchSceneVO(SceneID.GAME));
        }

        override public function transitionOut(): void
        {
            gameLoopDispatcher.stop();
            physicsUpdateSignal.removeAll();
            viewUpdateSignal.removeAll();

            gameModel.destroy();
            gameModel = null;

            //singletons & values
            injector.unmap(GameEndSignal);

            injector.unmap(IBulletDefs);
            injector.unmap(IEnemyDefs);
            injector.unmap(IComponentDefs);
            injector.unmap(IPlayerShipDefs);
            injector.unmap(IObstacleDefs);
            injector.unmap(IBehaviorFactory);
            injector.unmap(IEffectFactory);
            injector.unmap(IEffectDefs);
            injector.unmap(IBulletDefs);
            injector.unmap(IEffectActionProcessor);
            injector.unmap(IWeaponDefs);

            injector.unmap(TextureProvider);

            injector.unmap(ITouchController);
            injector.unmap(KeyController);
            injector.unmap(ILevelProvider);

            injector.unmap(IGameModel);

            //views
            mediatorMap.unmapView(GameView);
            mediatorMap.unmapView(GuiView);
            mediatorMap.unmapView(ResultsView);

            CONFIG::debug {
                mediatorMap.unmapView(DebugGameView);
            }

            Mouse.show();

            super.transitionOut();
        }

        private function handleSceneReady(aSceneReadyVO: SceneReadyVO): void
        {
            if (aSceneReadyVO.sceneID == SceneID.GAME)
            {
                sceneReadySignal.remove(handleSceneReady);
                transitionInFinishedSignal.dispatch();
            }
        }
    }
}
