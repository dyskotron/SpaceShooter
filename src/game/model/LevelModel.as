package game.model
{
    import game.model.levelModel.LevelEvent;

    import org.osflash.signals.Signal;
    import org.robotlegs.mvcs.Actor;

    public final class LevelModel extends Actor implements ILevelModel
    {
        private var _levelEvents: Vector.<LevelEvent>;
        private var _levelEventSignal: Signal;

        // fly thru level speed: m / s;
        public static const SPEED: uint = 200;

        private var _distance: Number = 0;

        /**
         * Model storing level events, when update is called it updates position and dispatches
         * level events if there are some.
         */
        public function LevelModel(aLevelEvents: Vector.<LevelEvent>)
        {
            _levelEventSignal = new Signal(LevelEvent);
            _levelEvents = aLevelEvents;
        }

        public function get levelEventSignal(): Signal
        {
            return _levelEventSignal;
        }

        public function progress(aDeltaTime: int): void
        {
            _distance += SPEED * aDeltaTime / 1000;

            var levelEvent: LevelEvent;
            while (_levelEvents.length > 0 && _levelEvents[0].distance < _distance)
            {
                levelEvent = _levelEvents.shift();
                _levelEventSignal.dispatch(levelEvent);
            }

        }


    }
}
