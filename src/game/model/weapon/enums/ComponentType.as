/**
 * Created with IntelliJ IDEA.
 * User: dysko
 * Date: 02/06/16
 * Time: 20:52
 * To change this template use File | Settings | File Templates.
 */
package game.model.weapon.enums
{
    public class ComponentType
    {
        //guns
        public static const MAIN_GUN: uint = 0x00001;
        public static const SECONDARY_GUN: uint = 0x0002;
        public static const ROCKET: uint = 0x0003;

        //energy
        public static const GENERATOR: uint = 0x00010;
        public static const BATTERY: uint = 0x00020;

        //other
        public static const SATELITE: uint = 0x0100;
        //dmg mitigation, hp, power boost, ext boost

        //groups
        public static const GUNS: uint = MAIN_GUN | SECONDARY_GUN | ROCKET;
        public static const MAIN_SLOT: uint = MAIN_GUN;
        public static const SECONDARY_SLOT: uint = SECONDARY_GUN | GENERATOR | BATTERY;
    }
}
