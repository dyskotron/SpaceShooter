package highScores.controller
{
    import common.controller.fsm.*;

    import main.controller.SwitchSceneSignal;
    import main.controller.SwitchSceneVO;
    import main.view.SceneID;

    public class HighScoresState extends AppState
    {
        [Inject]
        public var switchSceneSignal: SwitchSceneSignal;


        public function HighScoresState()
        {

        }

        override public function transitionIn(): void
        {
            //init or check flox service
            super.transitionIn();
        }

        override public function start(): void
        {
            switchSceneSignal.dispatch(new SwitchSceneVO(SceneID.HIGH_SCORES));
        }
    }
}
