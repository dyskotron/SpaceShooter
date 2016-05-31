/**
 * Created with IntelliJ IDEA.
 * User: dysko
 * Date: 02/06/16
 * Time: 20:51
 * To change this template use File | Settings | File Templates.
 */
package game.model.weapon
{
    public class WeaponSlot
    {
        private var _type: uint;
        private var _x: Number;
        private var _y: Number;
        private var _weaponModel: WeaponModel;

        public function WeaponSlot(aType: uint, aX: Number, aY: Number, aWeapon: WeaponModel = null)
        {
            _type = aType;
            _x = aX;
            _y = aY;
            _weaponModel = aWeapon;
        }

        public function get type(): uint
        {
            return _type;
        }

        public function get x(): Number
        {
            return _x;
        }

        public function get y(): Number
        {
            return _y;
        }

        public function get weaponModel(): WeaponModel
        {
            return _weaponModel;
        }

        public function hasWeapon(): Boolean
        {
            return _weaponModel != null;
        }

        public function setWeapon(aWeapon: WeaponModel = null): void
        {
            _weaponModel = aWeapon;
        }
    }
}
