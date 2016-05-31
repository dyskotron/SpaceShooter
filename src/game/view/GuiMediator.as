package game.view
{
    import common.model.TextureProvider;

    import game.controller.ViewUpdateSignal;
    import game.model.IGameModel;
    import game.model.gameObject.PlayerShipGO;

    import main.model.IViewModel;

    import org.robotlegs.mvcs.StarlingMediator;

    public class GuiMediator extends StarlingMediator
    {

        [Inject]
        public var textureProvider: TextureProvider;

        [Inject]
        public var gameModel: IGameModel;

        [Inject]
        public var viewModel: IViewModel;

        [Inject]
        public var guiView: GuiView;

        [Inject]
        public var viewUpdateSignal: ViewUpdateSignal;

        private var _playerModel: PlayerShipGO;

        override public function onRegister(): void
        {
            _playerModel = gameModel.getPlayerModelByID(guiView.playerID);
            _playerModel.statsUpdateSignal.add(statsUpdateHandler);

            guiView.init(viewModel, _playerModel, textureProvider);

            viewUpdateSignal.add(viewUpdateHandler);
        }

        override public function onRemove(): void
        {
            _playerModel.statsUpdateSignal.remove(statsUpdateHandler);

            viewUpdateSignal.remove(viewUpdateHandler);
        }

        private function viewUpdateHandler(aDeltaTime: int): void
        {
            guiView.updateEnergyDisplay(_playerModel);
        }

        private function statsUpdateHandler(): void
        {
            guiView.update(_playerModel);
        }
    }
}
