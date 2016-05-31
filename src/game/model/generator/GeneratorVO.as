/**
 * Created with IntelliJ IDEA.
 * User: dysko
 * Date: 01/06/16
 * Time: 19:29
 * To change this template use File | Settings | File Templates.
 */
package game.model.generator
{
    public class GeneratorVO
    {
        private var _capacity: Number;
        private var _rechargeSpeed: Number;

        /**
         * Defines generator and battery attributes
         * @param aCapacity
         * @param aRechargeSpeed
         */
        public function GeneratorVO(aCapacity: Number, aRechargeSpeed: Number)
        {
            _capacity = aCapacity;
            _rechargeSpeed = aRechargeSpeed;
        }

        public function get rechargeSpeed(): Number
        {
            return _rechargeSpeed;
        }

        public function get capacity(): Number
        {
            return _capacity;
        }
    }
}
