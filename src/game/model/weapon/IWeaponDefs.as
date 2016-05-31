package game.model.weapon
{
    public interface IWeaponDefs
    {
        function getPlayerWeaponVO(aWeaponType: uint): WeaponModel;

        function getEnemyWeaponVO(aWeaponID: uint, aShootInterval: uint, bulletType: uint): WeaponModel;
    }
}
