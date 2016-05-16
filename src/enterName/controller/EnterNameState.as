package enterName.controller
{
    import common.controller.fsm.*;

    import main.controller.SwitchSceneSignal;
    import main.controller.SwitchSceneVO;
    import main.view.SceneID;

    public class EnterNameState extends AppState
    {
        [Inject]
        public var switchSceneSignal: SwitchSceneSignal;

        public function EnterNameState()
        {

        }

        override public function start(): void
        {
            switchSceneSignal.dispatch(new SwitchSceneVO(SceneID.ENTER_NAME));
        }
    }
}
