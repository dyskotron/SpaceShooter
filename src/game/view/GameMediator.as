package game.view
{
    import common.model.TextureProvider;

    import game.controller.GameEndSignal;
    import game.controller.ViewUpdateSignal;
    import game.model.IGameModel;

    import main.model.IViewModel;
    import main.view.SceneViewMediator;

    public class GameMediator extends SceneViewMediator
    {
        [Inject]
        public var viewModel: IViewModel;

        [Inject]
        public var textureProvider: TextureProvider;

        [Inject]
        public var gameModel: IGameModel;

        [Inject]
        public var gameView: GameView;

        [Inject]
        public var viewUpdateSignal: ViewUpdateSignal;

        [Inject]
        public var gameOverSignal: GameEndSignal;

        public function GameMediator()
        {
            super();
        }

        override public function onRegister(): void
        {
            super.onRegister();

            gameView.init(viewModel, textureProvider, gameModel);

            viewUpdateSignal.add(gameLoopSignalHandler);
            gameOverSignal.add(gameEndSignalHandler);
        }

        override public function onRemove(): void
        {
            super.onRemove();

            viewUpdateSignal.remove(gameLoopSignalHandler);
            gameOverSignal.remove(gameEndSignalHandler);
        }

        private function gameLoopSignalHandler(aDeltaTime: Number): void
        {
            gameView.redraw(aDeltaTime);
        }

        private function gameEndSignalHandler(): void
        {
            gameView.showResults();
        }
    }
}
