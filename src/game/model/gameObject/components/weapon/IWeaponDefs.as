package game.model.gameObject.components.weapon
{
    public interface IWeaponDefs
    {
        function getMainWeaponModel(aWeaponType: uint): WeaponModel;

        function getSeconaryWeaponModel(aWeaponType: uint): WeaponModel;

        function getEnemyWeaponModel(aWeaponID: uint, aShootInterval: uint, bulletType: uint): WeaponModel;
    }
}
