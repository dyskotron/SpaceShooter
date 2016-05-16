package main.controller
{
    import org.osflash.signals.Signal;

    public class AppActivateSignal extends Signal
    {
        public function AppActivateSignal()
        {
            super(Boolean);
        }
    }
}