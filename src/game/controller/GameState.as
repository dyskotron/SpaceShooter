package game.controller
{
    import common.controller.fsm.*;
    import common.model.TextureProvider;

    import flash.ui.Mouse;

    import game.controller.playerControl.KeyController;
    import game.controller.playerControl.TouchController;
    import game.model.GameModel;
    import game.model.IGameModel;
    import game.model.ILevelModel;
    import game.model.LevelModel;
    import game.model.gameObject.def.BulletDefs;
    import game.model.gameObject.def.EnemyDefs;
    import game.model.gameObject.def.IBulletDefs;
    import game.model.gameObject.def.IEnemyDefs;
    import game.model.gameObject.def.IObstacleDefs;
    import game.model.gameObject.def.IPlayerShipDefs;
    import game.model.gameObject.def.ObstacleDefs;
    import game.model.gameObject.def.PlayerShipDefs;
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
            injector.mapSingletonOf(IPlayerShipDefs, PlayerShipDefs);
            injector.mapSingletonOf(IObstacleDefs, ObstacleDefs);

            injector.mapSingleton(TextureProvider);

            injector.mapSingleton(TouchController);
            injector.mapSingleton(KeyController);
            injector.mapSingletonOf(ILevelModel, LevelModel);

            //game model
            gameModel = new GameModel();
            injector.injectInto(gameModel);
            gameModel.init();
            injector.mapValue(IGameModel, gameModel);

            //views
            mediatorMap.mapView(GameView, GameMediator);
            mediatorMap.mapView(GuiView, GuiMediator);
            mediatorMap.mapView(ResultsView, ResultsMediator);

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
            injector.unmap(IPlayerShipDefs);
            injector.unmap(IObstacleDefs);

            injector.unmap(TextureProvider);

            injector.unmap(TouchController);
            injector.unmap(KeyController);
            injector.unmap(ILevelModel);

            injector.unmap(IGameModel);

            //views
            mediatorMap.unmapView(GameView);
            mediatorMap.unmapView(GuiView);
            mediatorMap.unmapView(ResultsView);

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