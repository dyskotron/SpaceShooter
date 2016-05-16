package highScores.controller
{
    import main.controller.MainFSM;

    import org.robotlegs.mvcs.StarlingSignalCommand;

    public class ShowHighScoresCommand extends StarlingSignalCommand
    {

        [Inject]
        public var fsm: MainFSM;

        override public function execute(): void
        {
            fsm.switchState(new HighScoresState());
        }
    }
}
