package home.view
{
    import common.controller.MenuPressedSignal;
    import common.view.MenuView;

    import feathers.controls.ButtonGroup;
    import feathers.data.ListCollection;

    import starling.events.Event;

    public class MainMenuView extends MenuView
    {
        public static const BUTTON_SINGLE_PLAYER: uint = 0;
        public static const BUTTON_TWO_PLAYERS: uint = 1;
        public static const BUTTON_HIGH_SCORES: uint = 2;

        public static const WIDTH: Number = 300;
        public static const HEIGHT: uint = 250;

        private var _buttonGroup: ButtonGroup;

        public function MainMenuView()
        {
            _menuPressedSignal = new MenuPressedSignal();

            _buttonGroup = new ButtonGroup();

            _buttonGroup.dataProvider = new ListCollection(
                    [
                        { label: "Single Player", triggered: singlePlayer_triggeredHandler },
                        { label: "Two Players", triggered: twoPLayers_triggeredHandler },
                        { label: "High Scores", triggered: highScores_triggeredHandler }
                    ]);

            _buttonGroup.setSize(WIDTH, HEIGHT);

            addChild(_buttonGroup);
        }

        override public function get width(): Number
        {
            return WIDTH;
        }

        override public function get height(): Number
        {
            return HEIGHT;
        }

        private function singlePlayer_triggeredHandler(aEvent: Event): void
        {
            _menuPressedSignal.dispatch(BUTTON_SINGLE_PLAYER);
        }

        private function twoPLayers_triggeredHandler(aEvent: Event): void
        {
            _menuPressedSignal.dispatch(BUTTON_TWO_PLAYERS);
        }

        private function highScores_triggeredHandler(aEvent: Event): void
        {
            _menuPressedSignal.dispatch(BUTTON_HIGH_SCORES);
        }
    }
}
