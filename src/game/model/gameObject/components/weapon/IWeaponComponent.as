package game.model.gameObject.components.weapon
{
    import game.model.gameObject.components.IComponent;

    public interface IWeaponComponent extends IComponent
    {
        function startShoot(): void

        function endShoot(): void

        function shoot(aX: Number, aY: Number): void

        function get weaponModel(): WeaponModel
    }
}
