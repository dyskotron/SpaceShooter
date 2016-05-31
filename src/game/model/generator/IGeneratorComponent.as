package game.model.generator
{
    public interface IGeneratorComponent
    {
        function update(aDeltaTime: int): void;

        function get energy(): Number;

        function get capacity(): Number;

        function deplete(aEnergyDelta: Number): Boolean

        function recharge(aEnergyDelta: Number): void
    }
}
