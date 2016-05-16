package common.controller
{
    import org.osflash.signals.Signal;

    public class MenuPressedSignal extends Signal
    {
        public function MenuPressedSignal()
        {
            super(uint);
        }
    }
}