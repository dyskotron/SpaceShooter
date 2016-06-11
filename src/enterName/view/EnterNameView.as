package enterName.view
{
    import common.controller.MenuPressedSignal;

    import feathers.controls.Button;
    import feathers.controls.Label;
    import feathers.controls.TextInput;

    import main.model.IMainModel;
    import main.model.IViewModel;
    import main.view.SceneID;
    import main.view.SceneView;

    import starling.events.Event;

    public class EnterNameView extends SceneView
    {
        public static const BUTTON_CONTINUE: uint = 0;

        private var _button: Button;
        private var _menuPressedSignal: MenuPressedSignal;
        private var _waitingLabel: Label;
        private var _input: TextInput;
        private var _noNamePLayerID: uint;

        private var _mainModel: IMainModel;

        public function EnterNameView()
        {
            super(SceneID.ENTER_NAME);

            _menuPressedSignal = new MenuPressedSignal();
        }

        public function get menuPressedSignal(): MenuPressedSignal
        {
            return _menuPressedSignal;
        }

        public function init(aViewModel: IViewModel, aMainModel: IMainModel): void
        {
            _mainModel = aMainModel;

            for (var i: int = 0; i < aMainModel.numPlayers; i++)
            {
                if (!aMainModel.getPlayerName(i))
                {
                    _noNamePLayerID = i;
                    break;
                }
            }

            _waitingLabel = new Label();
            _waitingLabel.text = "Enter name for player " + (_noNamePLayerID + 1);
            _waitingLabel.validate();
            _waitingLabel.x = (aViewModel.stageWidth - _waitingLabel.width) / 2;
            _waitingLabel.y = aViewModel.stageHeight / 2 - 50;
            addChild(_waitingLabel);

            _input = new TextInput();
            _input.validate();
            _input.x = (aViewModel.stageWidth - _input.width) / 2;
            _input.y = aViewModel.stageHeight / 2;
            _input.text = "Guest" + int(Math.random() * 1000);
            addChild(_input);

            _button = new Button();
            _button.label = "Continue ->";
            _button.validate();
            _button.x = (aViewModel.stageWidth - _button.width) / 2;
            _button.y = aViewModel.stageHeight - 100;
            _button.addEventListener(Event.TRIGGERED, continue_triggeredHandler);
            addChild(_button);
        }

        private function continue_triggeredHandler(aEvent: Event): void
        {
            _mainModel.setPlayerName(_noNamePLayerID, _input.text);
            _menuPressedSignal.dispatch(BUTTON_CONTINUE);
        }
    }
}
