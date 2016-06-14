package game.controller.playerControl
{
    import org.osflash.signals.Signal;

    /**
     * Signal for triggering one-shot action
     */
    public class ActionSwitchSignal extends Signal
    {
        public function ActionSwitchSignal()
        {
            super(uint, uint);
        }
    }
}
