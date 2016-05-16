package main.controller
{

    import starling.display.Stage;

    public class InitMainVO
    {
        private var _stage: Stage;

        public function InitMainVO(aStage: Stage): void
        {
            _stage = aStage;
        }

        public function get stage(): Stage
        {
            return _stage;
        }
    }
}