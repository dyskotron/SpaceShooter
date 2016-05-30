package game.model.weapon
{
    public interface IWeaponDefs
    {
        function getWeaponVO(aWeaponType: uint, aShootInterval: uint, bulletType: uint): WeaponModel;
    }
}
