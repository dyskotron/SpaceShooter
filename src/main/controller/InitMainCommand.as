package main.controller
{
    import home.controller.HomeState;

    import main.model.IViewModel;

    import org.robotlegs.mvcs.StarlingSignalCommand;

    public class InitMainCommand extends StarlingSignalCommand
    {
        [Inject]
        public var viewModel: IViewModel;

        [Inject]
        public var initMainVO: InitMainVO;

        [Inject]
        public var fsm: MainFSM;

        override public function execute(): void
        {
            viewModel.init(initMainVO.stage);
            fsm.switchState(new HomeState());
        }
    }
}
