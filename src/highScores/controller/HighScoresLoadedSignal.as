package highScores.controller
{
    import org.osflash.signals.Signal;

    public class HighScoresLoadedSignal extends Signal
    {
        public function HighScoresLoadedSignal()
        {
            super(HighScoreLoadedSignalVO);
        }
    }
}
