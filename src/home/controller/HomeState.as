package home.controller
{
    import common.controller.fsm.*;

    import main.controller.SwitchSceneSignal;
    import main.controller.SwitchSceneVO;
    import main.view.SceneID;

    public class HomeState extends AppState
    {
        [Inject]
        public var switchSceneSignal: SwitchSceneSignal;


        public function HomeState()
        {

        }

        override public function start(): void
        {
            switchSceneSignal.dispatch(new SwitchSceneVO(SceneID.HOME));
        }
    }
}
