package game.controller.playerControl
{
    import org.osflash.signals.Signal;

    /**
     * Signal for turning continuous action on or off
     */
    public class ActionEnableSignal extends Signal
    {
        public function ActionEnableSignal()
        {
            super(uint, uint, Boolean);
        }
    }
}
