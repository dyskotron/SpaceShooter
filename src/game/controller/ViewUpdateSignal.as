package game.controller
{
    import org.osflash.signals.Signal;

    public class ViewUpdateSignal extends Signal
    {
        public function ViewUpdateSignal()
        {
            super(int);
        }
    }
}
