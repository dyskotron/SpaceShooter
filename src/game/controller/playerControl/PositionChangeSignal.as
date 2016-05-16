package game.controller.playerControl
{
    import org.osflash.signals.Signal;

    /**
     * Signal for sending absolute position of control(e.g. mouse or touch)
     */
    public class PositionChangeSignal extends Signal
    {
        public function PositionChangeSignal()
        {
            super(uint, Number, Number);
        }
    }
}
