/**
 * Created with IntelliJ IDEA.
 * User: dysko
 * Date: 01/06/16
 * Time: 19:29
 * To change this template use File | Settings | File Templates.
 */
package game.model.gameObject.component.generator
{
    import game.model.gameObject.component.Component;

    public class EnergyComponent extends Component implements IGeneratorComponent
    {
        private var _energy: Number;
        private var _capacity: Number;
        private var _isFull: Boolean;
        private var _rechargeSpeed: Number;
        private var _percentLeft: int;

        /**
         * Maintain battery, energy consumption and recharging
         * @param aCapacity
         * @param aRechargeSpeed
         */
        public function EnergyComponent(aCapacity: Number, aRechargeSpeed: Number)
        {
            trace("_MO_", this, "CREATED ENERGY COMPONENT", "aCapacity:", aCapacity, "aRechargeSpeed:", aRechargeSpeed);
            _energy = _capacity = aCapacity;
            _rechargeSpeed = aRechargeSpeed;
            _percentLeft = 100;
        }

        override public function update(aDeltaTime: int): void
        {
            recharge(_rechargeSpeed * aDeltaTime / 1000);
        }

        public function get energy(): Number
        {
            return _energy;
        }

        public function get capacity(): Number
        {
            return _capacity;
        }

        public function get percentLeft(): int
        {
            return _percentLeft;
        }

        public function recharge(aEnergyDelta: Number): void
        {
            _energy = Math.min(_energy + aEnergyDelta, _capacity);
            _isFull = (_capacity == _energy);
            _percentLeft = _energy / _capacity * 100;
        }


        public function deplete(aEnergyDelta: Number): Boolean
        {
            if (aEnergyDelta > _energy)
                return false;

            _energy -= aEnergyDelta;
            _percentLeft = _energy / _capacity * 100;
            return true;
        }

        public function isFull(): Boolean
        {
            return _isFull;
        }


    }
}
