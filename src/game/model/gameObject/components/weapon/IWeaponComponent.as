package game.model.gameObject.components.weapon
{
    public interface IWeaponComponent
    {
        function update(aDeltaTime: int, aShipX: Number, aShipY: Number): void

        function startShoot(): void

        function endShoot(): void

        function get weaponModel(): WeaponModel
    }
}
