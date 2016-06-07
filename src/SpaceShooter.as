package
{


    import com.gamua.flox.Flox;

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
         * - weapon/equip slots have also orientation - angle - change bullets and all this shit to polar cords
         * - move vector of weapon slots to weapons model with addWeapon method which will move guns to right slots
         *
         * - disable enemy hits out of screen
         * - check bulletVO defs - could be static / just created once
         * - unify SomethingType and SomethingID
         * - change target inputs in level generator to normalized 0 - 1 (+ do the same for size for all game objects later?)
         * - add msg / alerts - player based or level based
         * - count size of GameObjects in *Defs from xml, not textures
         * - main app states could be better connected to its own views - always switching scene as last thing in transition in
         * and waiting when it is ready  + anim in/out for scenes + ViewScene mediator should call destroy on views instead of MainView
         * - consider testing if dispatching one signal with vector of shots or dispatching signals for individual shots is faster
         *
         * NEXT STEPS:
         * - pooling
         * - better collision
         * - parsing definition of game objects and levels from json(or better binary) which could be created in level designer
         * - mem values protection
         */
        private var _starling: Starling;

        public function SpaceShooter()
        {
            Flox.init("CxMB90Cjm7HGbnQI", "MFxnMZD3B3iLEZ0L", CONFIG::version);

            stage.align = StageAlign.TOP;
            stage.scaleMode = StageScaleMode.SHOW_ALL;

            this.loaderInfo.addEventListener(Event.COMPLETE, completeHandler);

            CONFIG::debug {
                var stats: Stats = new Stats();
                addChild(stats);
                stats.x = stage.stageWidth - stats.width;
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
