package main.controller
{
    import org.osflash.signals.Signal;

    public class InitMainSignal extends Signal
    {
        public function InitMainSignal()
        {
            super(InitMainVO);
        }
    }
}