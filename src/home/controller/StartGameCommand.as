package home.controller
{
    import enterName.controller.EnterNameState;

    import game.controller.GameState;

    import main.controller.MainFSM;
    import main.model.IMainModel;

    import org.robotlegs.mvcs.StarlingSignalCommand;

    public class StartGameCommand extends StarlingSignalCommand
    {

        [Inject]
        public var fsm: MainFSM;

        [Inject]
        public var mainModel: IMainModel;

        [Inject]
        public var startGameSignalVO: StartGameSignalVO;

        /**
         *
         */
        override public function execute(): void
        {
            mainModel.numPlayers = startGameSignalVO.numPlayers;

            for (var i: int = 0; i < startGameSignalVO.numPlayers; i++)
            {
                if (!mainModel.getPlayerName(i))
                {
                    fsm.switchState(new EnterNameState());
                    return;
                }
            }

            fsm.switchState(new GameState());
        }
    }
}
