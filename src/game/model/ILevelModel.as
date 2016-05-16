package game.model
{
    import org.osflash.signals.Signal;

    public interface ILevelModel
    {
        function get levelEventSignal(): Signal;

        function init(): void;

        function progress(aDeltaTime: int): void;
    }
}
