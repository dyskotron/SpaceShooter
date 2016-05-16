package main.controller
{
    import org.osflash.signals.Signal;

    public class SceneReadySignal extends Signal
    {
        public function SceneReadySignal()
        {
            super(SceneReadyVO);
        }
    }
}
