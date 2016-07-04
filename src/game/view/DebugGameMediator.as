package game.view
{
    import game.controller.GameEndSignal;
    import game.controller.ViewUpdateSignal;
    import game.model.IGameModel;

    import org.robotlegs.mvcs.StarlingMediator;

    public class DebugGameMediator extends StarlingMediator
    {
        [Inject]
        public var gameModel: IGameModel;

        [Inject]
        public var debugGameView: DebugGameView;

        [Inject]
        public var viewUpdateSignal: ViewUpdateSignal;

        [Inject]
        public var gameOverSignal: GameEndSignal;

        public function DebugGameMediator()
        {
            super();
        }

        override public function onRegister(): void
        {
            super.onRegister();

            debugGameView.init(gameModel);

            viewUpdateSignal.add(gameLoopSignalHandler);
        }

        override public function onRemove(): void
        {
            viewUpdateSignal.remove(gameLoopSignalHandler);

            debugGameView.destroy();
        }

        private function gameLoopSignalHandler(aDeltaTime: Number): void
        {
            debugGameView.redraw(aDeltaTime);
        }
    }
}
