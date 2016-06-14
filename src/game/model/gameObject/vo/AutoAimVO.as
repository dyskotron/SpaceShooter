package game.model.gameObject.vo
{
    public class AutoAimVO
    {
        private var _mode: uint;
        private var _maxTriggerAngle: Number;
        private var _maxRotation: int;

        public function AutoAimVO(aAimMode: uint, aMaxTriggerAngle: Number = 0, aMaxRotation = 0)
        {
            _mode = aAimMode;
            _maxTriggerAngle = aMaxTriggerAngle;
            _maxRotation = aMaxRotation;
        }

        public function get mode(): uint
        {
            return _mode;
        }

        public function get maxTriggerAngle(): Number
        {
            return _maxTriggerAngle;
        }

        public function get maxRotation(): int
        {
            return _maxRotation;
        }
    }
}
