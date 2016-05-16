package home.controller
{
    import org.osflash.signals.Signal;

    public class StartGameSignal extends Signal
    {
        public function StartGameSignal(): void
        {
            super(StartGameSignalVO);
        }
    }
}
