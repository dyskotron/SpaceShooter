package main
{

    import enterName.view.EnterNameMediator;
    import enterName.view.EnterNameView;

    import game.controller.BackToMenuCommand;
    import game.controller.BackToMenuSignal;
    import game.controller.GameLoopDispatcher;
    import game.controller.PhysicsUpdateSignal;
    import game.controller.ViewUpdateSignal;

    import highScores.controller.HighScoresFailedSignal;
    import highScores.controller.HighScoresLoadedSignal;
    import highScores.controller.ShowHighScoresCommand;
    import highScores.controller.ShowHighScoresSignal;
    import highScores.model.FloxService;
    import highScores.model.IHighScoreService;
    import highScores.view.HighScoresMediator;
    import highScores.view.HighScoresView;

    import home.controller.StartGameCommand;
    import home.controller.StartGameSignal;
    import home.view.HomeMediator;
    import home.view.HomeView;
    import home.view.MainMenuMediator;
    import home.view.MainMenuView;

    import main.controller.AppActivateSignal;
    import main.controller.InitMainCommand;
    import main.controller.InitMainSignal;
    import main.controller.MainFSM;
    import main.controller.SceneReadySignal;
    import main.controller.SwitchSceneCommand;
    import main.controller.SwitchSceneSignal;
    import main.model.IMainModel;
    import main.model.IViewModel;
    import main.model.MainModel;
    import main.model.ViewModel;
    import main.view.MainMediator;
    import main.view.MainView;

    import org.robotlegs.base.SignalCommandMap;
    import org.robotlegs.base.StarlingMediatorMap;
    import org.robotlegs.mvcs.SignalStarlingContext;

    public class MainContext extends SignalStarlingContext
    {

        override public function startup(): void
        {
            mapGame();

            mapHome();

            mapHighScores();

            mapEnterName();

            mapMain();

            super.startup();
        }

        private function mapGame(): void
        {
            injector.mapSingleton(GameLoopDispatcher);
            injector.mapSingleton(PhysicsUpdateSignal);
            injector.mapSingleton(ViewUpdateSignal);

            //remaining dependencies are mapped in gameState
        }

        private function mapHome(): void
        {
            signalCommandMap.mapSignalClass(StartGameSignal, StartGameCommand);

            mediatorMap.mapView(HomeView, HomeMediator);
            mediatorMap.mapView(MainMenuView, MainMenuMediator);
        }

        private function mapHighScores(): void
        {
            signalCommandMap.mapSignalClass(ShowHighScoresSignal, ShowHighScoresCommand);

            mediatorMap.mapView(HighScoresView, HighScoresMediator);
        }

        private function mapEnterName(): void
        {
            mediatorMap.mapView(EnterNameView, EnterNameMediator);
        }

        private function mapMain(): void
        {
            injector.mapValue(StarlingMediatorMap, mediatorMap);
            injector.mapValue(SignalCommandMap, signalCommandMap);

            injector.mapSingleton(AppActivateSignal);

            injector.mapSingletonOf(IHighScoreService, FloxService);
            injector.mapSingleton(HighScoresLoadedSignal);
            injector.mapSingleton(HighScoresFailedSignal);

            injector.mapSingletonOf(IViewModel, ViewModel);
            injector.mapSingletonOf(IMainModel, MainModel);
            injector.mapSingleton(MainFSM);
            injector.mapSingleton(SceneReadySignal);
            injector.mapSingleton(BackToMenuSignal);

            signalCommandMap.mapSignalClass(InitMainSignal, InitMainCommand);
            signalCommandMap.mapSignalClass(SwitchSceneSignal, SwitchSceneCommand);
            signalCommandMap.mapSignalClass(BackToMenuSignal, BackToMenuCommand);

            mediatorMap.mapView(MainView, MainMediator);
        }
    }

}


