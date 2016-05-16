package highScores.view
{
    import com.gamua.flox.Score;

    import common.controller.MenuPressedSignal;

    import feathers.controls.Button;
    import feathers.controls.Label;
    import feathers.controls.LayoutGroup;
    import feathers.layout.VerticalLayout;

    import flash.utils.getTimer;

    import main.model.IViewModel;
    import main.view.SceneID;
    import main.view.SceneView;

    import starling.display.Sprite;
    import starling.events.Event;

    public class HighScoresView extends SceneView
    {
        public static const BUTTON_BACK_TO_MENU: uint = 0;

        private static const SCORE_TABLE_WIDTH: uint = 400;

        private var _button: Button;
        private var _menuPressedSignal: MenuPressedSignal;
        private var _layoutGroup: LayoutGroup;
        private var _waitingLabel: Label;
        private var _viewModel: IViewModel;

        public function HighScoresView()
        {
            super(SceneID.HIGH_SCORES);

            _menuPressedSignal = new MenuPressedSignal();
        }

        public function get menuPressedSignal(): MenuPressedSignal
        {
            return _menuPressedSignal;
        }

        public function init(aViewModel: IViewModel): void
        {
            _viewModel = aViewModel;

            _waitingLabel = new Label();
            _waitingLabel.text = "Retrieving high scores ...";
            _waitingLabel.validate();
            _waitingLabel.x = (aViewModel.stageWidth - _waitingLabel.width) / 2;
            _waitingLabel.y = aViewModel.stageHeight / 2 - 50;
            addChild(_waitingLabel);

            stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);


            _button = new Button();
            _button.label = "Back to menu";
            _button.validate();
            _button.x = (aViewModel.stageWidth - _button.width) / 2;
            _button.y = aViewModel.stageHeight - 100;
            _button.addEventListener(Event.TRIGGERED, backToMenu_triggeredHandler);
            addChild(_button);
        }

        public function showHighScores(aScores: Array): void
        {
            hideWaitingMessage();

            var layout: VerticalLayout = new VerticalLayout();
            layout.gap = 10;
            _layoutGroup = new LayoutGroup();
            _layoutGroup.layout = layout;
            _layoutGroup.x = _viewModel.stageWidth / 2;
            _layoutGroup.y = 100;
            addChild(_layoutGroup);

            var score: Score
            var nameLabel: Label;
            var scoreLabel: Label;
            var coreRow: Sprite;

            for (var i: int = 0; i < Math.min(aScores.length, 20); i++)
            {
                score = aScores[i];

                coreRow = new Sprite();
                coreRow.height = 30;
                coreRow.width = SCORE_TABLE_WIDTH;
                coreRow.x = _viewModel.stageWidth / 2;

                nameLabel = new Label();
                nameLabel.text = score.playerName;
                nameLabel.x = -SCORE_TABLE_WIDTH / 2;
                coreRow.addChild(nameLabel);

                scoreLabel = new Label();
                scoreLabel.text = score.value.toString();
                scoreLabel.validate();
                scoreLabel.x = SCORE_TABLE_WIDTH / 2 - scoreLabel.width;
                coreRow.addChild(scoreLabel);

                _layoutGroup.addChild(coreRow);
            }
        }

        public function showError(errorMessage: String): void
        {
            hideWaitingMessage();

            var errorTitle: Label = new Label();
            errorTitle.text = "Error when retrieving high scores:";
            errorTitle.validate();
            errorTitle.x = (_viewModel.stageWidth - errorTitle.width) / 2;
            errorTitle.y = _viewModel.stageHeight / 2 - 50;
            addChild(errorTitle);


            var errorLabel: Label = new Label();
            errorLabel.text = "Check your internet connection and try it later, maybe?";
            errorLabel.validate();
            errorLabel.x = (_viewModel.stageWidth - errorLabel.width) / 2;
            errorLabel.y = _viewModel.stageHeight / 2 - 10;
            addChild(errorLabel);
        }

        override public function destroy(): void
        {
            stage.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
        }

        private function hideWaitingMessage(): void
        {
            removeChild(_waitingLabel);
            stage.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
        }

        private function backToMenu_triggeredHandler(aEvent: Event): void
        {
            _menuPressedSignal.dispatch(BUTTON_BACK_TO_MENU);
        }

        private function enterFrameHandler(aEvent: Event): void
        {
            _waitingLabel.alpha = Math.sin(getTimer() / 100);
        }
    }
}
