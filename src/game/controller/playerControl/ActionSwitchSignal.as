package game.controller.playerControl
{
    import org.osflash.signals.Signal;

    /**
     * Signal for turning continuous action on or off
     */
    public class ActionSwitchSignal extends Signal
    {
        public function ActionSwitchSignal()
        {
            super(uint, uint, Boolean);
        }
    }
}
