package enterName.view
{
    import home.controller.StartGameSignal;
    import home.controller.StartGameSignalVO;

    import main.model.IMainModel;
    import main.model.IViewModel;
    import main.view.SceneViewMediator;

    public class EnterNameMediator extends SceneViewMediator
    {
        [Inject]
        public var enterNameView: EnterNameView;

        [Inject]
        public var startGameSignal: StartGameSignal;

        [Inject]
        public var viewModel: IViewModel;

        [Inject]
        public var mainModel: IMainModel;

        override public function onRegister(): void
        {
            super.onRegister();

            enterNameView.init(viewModel, mainModel);
            enterNameView.menuPressedSignal.add(menuPressedHandler);
        }

        override public function onRemove(): void
        {
            enterNameView.menuPressedSignal.remove(menuPressedHandler);
        }

        private function menuPressedHandler(aButtonID: uint): void
        {
            switch (aButtonID)
            {
                case EnterNameView.BUTTON_CONTINUE:
                    startGameSignal.dispatch(new StartGameSignalVO(mainModel.numPlayers));
                    break;
            }
        }
    }
}
