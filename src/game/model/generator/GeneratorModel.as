/**
 * Created with IntelliJ IDEA.
 * User: dysko
 * Date: 01/06/16
 * Time: 19:29
 * To change this template use File | Settings | File Templates.
 */
package game.model.generator
{
    import game.model.weapon.ComponentModel;
    import game.model.weapon.enums.ComponentType;

    public class GeneratorModel extends ComponentModel
    {
        private var _rechargeSpeed: Number;

        public function GeneratorModel(aComponentID: uint, aRechargeSpeed: Number)
        {
            _rechargeSpeed = aRechargeSpeed;

            super(aComponentID, ComponentType.GENERATOR);
        }

        public function get rechargeSpeed(): Number
        {
            return _rechargeSpeed;
        }
    }
}
