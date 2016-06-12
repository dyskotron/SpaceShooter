/**
 * Created with IntelliJ IDEA.
 * User: dysko
 * Date: 01/06/16
 * Time: 19:29
 * To change this template use File | Settings | File Templates.
 */
package game.model.gameObject.components.generator
{
    public class EnergyComponent implements IGeneratorComponent
    {
        private var _energy: Number;
        private var _capacity: Number;
        private var _isFull: Boolean;
        private var _rechargeSpeed: Number;

        /**
         * Maintain battery, energy consumption and recharging
         * @param generatorVO
         */
        public function EnergyComponent(aCapacity: Number, aRechargeSpeed: Number)
        {
            trace("_MO_", this, "CREATED ENERGY COMPONENT", "aCapacity:", aCapacity, "aRechargeSpeed:", aRechargeSpeed);
            _energy = _capacity = aCapacity;
            _rechargeSpeed = aRechargeSpeed;
        }

        public function update(aDeltaTime: int): void
        {
            recharge(_rechargeSpeed * aDeltaTime / 1000);
            _isFull = (_capacity == _energy);
        }

        public function get energy(): Number
        {
            return _energy;
        }

        public function get capacity(): Number
        {
            return _capacity;
        }

        public function recharge(aEnergyDelta: Number): void
        {
            _energy = Math.min(_energy + aEnergyDelta, _capacity);
        }

        public function deplete(aEnergyDelta: Number): Boolean
        {
            if (aEnergyDelta > _energy)
                return false;

            _energy -= aEnergyDelta;
            return true;
        }

        public function isFull(): Boolean
        {
            return _isFull;
        }
    }
}
