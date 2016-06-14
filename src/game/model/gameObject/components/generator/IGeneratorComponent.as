package game.model.gameObject.components.generator
{
    public interface IGeneratorComponent
    {
        function update(aDeltaTime: int): void;

        function get energy(): Number;

        function get capacity(): Number;

        function get percentLeft(): int;

        function deplete(aEnergyDelta: Number): Boolean

        function recharge(aEnergyDelta: Number): void

        function isFull(): Boolean;
    }
}
