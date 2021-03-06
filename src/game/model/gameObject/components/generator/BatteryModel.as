/**
 * Created with IntelliJ IDEA.
 * User: dysko
 * Date: 01/06/16
 * Time: 19:29
 * To change this template use File | Settings | File Templates.
 */
package game.model.gameObject.components.generator
{
    import game.model.gameObject.components.ComponentType;
    import game.model.gameObject.components.weapon.ComponentModel;

    public class BatteryModel extends ComponentModel
    {
        private var _capacity: Number;

        public function BatteryModel(aComponentID: uint, aCapacity: Number)
        {
            _capacity = aCapacity;

            super(aComponentID, ComponentType.BATTERY);
        }

        public function get capacity(): Number
        {
            return _capacity;
        }
    }
}
