package game.model.gameObject.component.weapon
{
    public interface IWeaponDefs
    {
        function getMainWeaponModel(aWeaponType: uint): WeaponModel;

        function getSecondaryWeaponModel(aWeaponType: uint): WeaponModel;

        function getEnemyWeaponModel(aWeaponID: uint, aShootInterval: uint, bulletType: uint): WeaponModel;
    }
}
