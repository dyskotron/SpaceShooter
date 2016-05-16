package highScores.model
{
    import com.gamua.flox.Flox;
    import com.gamua.flox.TimeScope;

    import highScores.controller.HighScoreFailedSignalVO;
    import highScores.controller.HighScoreLoadedSignalVO;
    import highScores.controller.HighScoresFailedSignal;
    import highScores.controller.HighScoresLoadedSignal;

    import org.robotlegs.mvcs.Actor;

    public class FloxService extends Actor implements IHighScoreService
    {
        [Inject]
        public var highScoresLoadedSignal: HighScoresLoadedSignal;

        [Inject]
        public var highScoresFailedSignal: HighScoresFailedSignal;


        public function FloxService()
        {
            Flox.init("CxMB90Cjm7HGbnQI", "MFxnMZD3B3iLEZ0L", "0.9");
        }

        public function saveScore(aPlayerName: String, aScore: Number): void
        {
            Flox.postScore("score", aScore, aPlayerName);
        }

        public function getHighScores(): void
        {
            Flox.loadScores("score", TimeScope.ALL_TIME, scoreLoadedHandler, scoreErrorHandler);
        }

        private function scoreLoadedHandler(aScores: Array): void
        {
            highScoresLoadedSignal.dispatch(new HighScoreLoadedSignalVO(aScores));
        }

        private function scoreErrorHandler(aError: String): void
        {
            highScoresFailedSignal.dispatch(new HighScoreFailedSignalVO(aError));
        }


    }
}
