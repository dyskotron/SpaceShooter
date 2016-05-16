package game.controller.playerControl
{
    import org.osflash.signals.Signal;

    /**
     * Signal for sending change direction or position(in this case not absolute but just delta coordinates)
     */
    public class DirectionChangeSignal extends Signal
    {
        public function DirectionChangeSignal()
        {
            super(uint, Number, Number);
        }
    }
}
