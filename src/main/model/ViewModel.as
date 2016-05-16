package main.model
{
    import org.robotlegs.mvcs.Actor;

    import starling.display.Stage;

    public class ViewModel extends Actor implements IViewModel
    {
        private var _stageWidth: Number;
        private var _stageHeight: Number;
        private var _stage: Stage;

        /**
         * Model for storing main view properties and settings
         */
        public function ViewModel()
        {
            super();
        }

        public function get stage(): Stage
        {
            return _stage;
        }

        public function get gameWidth(): Number
        {
            return _stageWidth;
        }

        public function get gameHeight(): Number
        {
            return _stageHeight;
        }

        public function get stageWidth(): Number
        {
            return _stageWidth;
        }

        public function get stageHeight(): Number
        {
            return _stageHeight;
        }

        public function init(aStage: Stage): void
        {
            _stageWidth = aStage.stageWidth;
            _stageHeight = aStage.stageHeight;
            _stage = aStage;
        }
    }
}
