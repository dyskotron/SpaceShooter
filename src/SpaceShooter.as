package
{


    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.geom.Rectangle;

    import main.view.MainView;

    import net.hires.debug.Stats;

    import starling.core.Starling;

    [SWF(frameRate="60", width="1024", height="768", backgroundColor=0x111111)]
    public class SpaceShooter extends Sprite
    {

        /**
         * TODO / IDEAS:
         * - split level model to model & generator
         * - add msg / alerts - player based or level based
         * - wrong collision bug
         * - count size of GameObjects in *Defs from xml, not textures
         * - main app states could be better connected to its own views - always switching scene as last thing in transition in
         * and waiting when it is ready
         * - consider testing if dispatching one signal with vector of shots or dispatching signals for individual shots is faster
         *
         * NEXT STEPS:
         * - pooling
         * - pixel perfect collision or more rectangles for one gameObject which would be closer gameObject's shape
         * - parsing definition of game objects and levels from json(or better binary) which could be created in level designer
         * - fsm for smarter enemies
         * - mem values protection
         */
        private var _starling: Starling;

        public function SpaceShooter()
        {
            stage.align = StageAlign.TOP;
            stage.scaleMode = StageScaleMode.NO_SCALE;

            this.loaderInfo.addEventListener(Event.COMPLETE, completeHandler);

            CONFIG::debug {
                addChild(new Stats());
            }
        }

        protected function completeHandler(aEvent: Event): void
        {
            Starling.handleLostContext = true;
            Starling.multitouchEnabled = true;

            _starling = new Starling(MainView, this.stage);
            _starling.antiAliasing = 1;
            Starling.current.enableErrorChecking = false;
            Starling.current.start();

            this.stage.addEventListener(Event.RESIZE, resizeHandler, false, int.MAX_VALUE, true);
            this.stage.addEventListener(Event.DEACTIVATE, deactivateHandler, false, 0, true);
        }

        protected function resizeHandler(aEvent: Event): void
        {
            Starling.current.stage.stageWidth = this.stage.fullScreenWidth;
            Starling.current.stage.stageHeight = this.stage.fullScreenHeight;

            const viewPort: Rectangle = _starling.viewPort;
            viewPort.width = this.stage.fullScreenWidth;
            viewPort.height = this.stage.fullScreenHeight;

            try
            {
                Starling.current.viewPort = viewPort;
            }
            catch (error: Error)
            {
                trace("_MO_", this, error.message);
            }
        }

        protected function deactivateHandler(aEvent: Event): void
        {
            if (this.stage)
            {
                Starling.current.stop();
                this.stage.addEventListener(Event.ACTIVATE, activateHandler, false, 0, true);
            }
        }

        private function activateHandler(aEvent: Event): void
        {
            if (this.stage)
            {
                this.stage.removeEventListener(Event.ACTIVATE, activateHandler);
                Starling.current.start();
            }
        }

    }
}