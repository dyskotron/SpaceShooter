package game.model.gameObject.component.effect
{
    public class EffectVO
    {
        private var _effectID: uint;
        private var _type: uint;
        private var _target: uint;
        private var _length: Number;
        private var _param1: Number;
        private var _param2: Number;

        public function EffectVO(aEffectID: uint, aType: uint, aTarget: uint, aLength: Number, aParam1: Number = 0, aParam2: Number = 0)
        {
            _effectID = aEffectID;
            _type = aType;
            _target = aTarget;
            _length = aLength;
            _param1 = aParam1;
            _param2 = aParam2;
        }

        public function get effectID(): uint
        {
            return _effectID;
        }

        public function get type(): uint
        {
            return _type;
        }

        public function get target(): uint
        {
            return _target;
        }

        public function get length(): Number
        {
            return _length;
        }

        public function get param1(): Number
        {
            return _param1;
        }

        public function get param2(): Number
        {
            return _param2;
        }
    }
}
