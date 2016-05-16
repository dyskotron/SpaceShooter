package game.controller
{
    import home.controller.HomeState;

    import main.controller.MainFSM;

    import org.robotlegs.mvcs.StarlingSignalCommand;

    public class BackToMenuCommand extends StarlingSignalCommand
    {

        [Inject]
        public var fsm: MainFSM;

        override public function execute(): void
        {
            fsm.switchState(new HomeState());
        }
    }
}
