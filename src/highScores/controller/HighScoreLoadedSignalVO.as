package highScores.controller
{
    public class HighScoreLoadedSignalVO
    {
        private var _highScores: Array;

        public function HighScoreLoadedSignalVO(aHighScores: Array)
        {
            _highScores = aHighScores;
        }

        public function get highScores(): Array
        {
            return _highScores;
        }
    }
}
