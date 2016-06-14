package game.controller.playerControl
{
    import org.osflash.signals.Signal;

    /**
     * Signal for triggering one-shot action
     */
    public class ActionTriggerSignal extends Signal
    {
        public function ActionTriggerSignal()
        {
            super(uint, uint);
        }
    }
}
