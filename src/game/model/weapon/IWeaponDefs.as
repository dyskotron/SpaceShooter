package game.model.weapon
{
    public interface IWeaponDefs
    {
        function getPlayerWeaponModel(aWeaponType: uint): WeaponModel;

        function getEnemyWeaponModel(aWeaponID: uint, aShootInterval: uint, bulletType: uint): WeaponModel;
    }
}
