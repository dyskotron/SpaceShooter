package main.controller
{
    import main.model.IViewModel;
    import main.view.MainView;

    import org.robotlegs.mvcs.StarlingSignalCommand;

    public class SwitchSceneCommand extends StarlingSignalCommand
    {
        [Inject]
        public var model: IViewModel;

        [Inject]
        public var signalVO: SwitchSceneVO;

        override public function execute(): void
        {
            MainView(contextView).scene = signalVO.sceneID;
        }
    }
}
