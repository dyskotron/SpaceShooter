package highScores.controller
{
    public class HighScoreFailedSignalVO
    {
        private var _errorMessage: String;

        public function HighScoreFailedSignalVO(aErrorMessage: String)
        {
            _errorMessage = aErrorMessage;
        }

        public function get errorMessage(): String
        {
            return _errorMessage;
        }
    }
}
