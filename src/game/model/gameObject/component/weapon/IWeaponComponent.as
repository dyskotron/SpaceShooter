package game.model.gameObject.component.weapon
{
    import game.model.gameObject.component.IComponent;

    public interface IWeaponComponent extends IComponent
    {
        function startShoot(aNextShotAfter: Number = 0): void

        function endShoot(): void

        function shoot(aX: Number, aY: Number): void

        function get weaponModel(): WeaponModel
    }
}
