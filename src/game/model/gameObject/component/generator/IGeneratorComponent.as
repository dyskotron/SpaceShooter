package game.model.gameObject.component.generator
{
    import game.model.gameObject.component.IComponent;

    public interface IGeneratorComponent extends IComponent
    {
        function get energy(): Number;

        function get capacity(): Number;

        function get percentLeft(): int;

        function deplete(aEnergyDelta: Number): Boolean

        function recharge(aEnergyDelta: Number): void

        function isFull(): Boolean;
    }
}
