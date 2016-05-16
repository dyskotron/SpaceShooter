package highScores.controller
{
    import org.osflash.signals.Signal;

    public class HighScoresFailedSignal extends Signal
    {
        public function HighScoresFailedSignal()
        {
            super(HighScoreFailedSignalVO);
        }
    }
}
