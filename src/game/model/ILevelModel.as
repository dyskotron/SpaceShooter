package game.model
{
    import org.osflash.signals.Signal;

    public interface ILevelModel
    {
        function get levelEventSignal(): Signal;

        function progress(aDeltaTime: int): void;
    }
}
