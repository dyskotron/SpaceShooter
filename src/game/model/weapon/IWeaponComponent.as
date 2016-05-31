package game.model.weapon
{
    public interface IWeaponComponent
    {
        function update(aDeltaTime: int, aShipX: Number, aShipY: Number): void

        function startShoot(): void

        function stopShoot(): void
    }
}
