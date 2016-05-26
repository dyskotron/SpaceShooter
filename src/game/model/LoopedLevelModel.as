package game.model
{
    import game.model.levelModel.LevelEvent;

    import org.osflash.signals.Signal;
    import org.robotlegs.mvcs.Actor;

    public final class LoopedLevelModel extends Actor implements ILevelModel
    {
        private var _levelEvents: Vector.<LevelEvent>;
        private var _levelEventSignal: Signal;

        // fly thru level speed: m / s;
        public static const SPEED: uint = 200;

        private var _distance: Number = 0;
        private var _currentEventIndex: Number = 0;

        /**
         * Simple looped LevelModel, for testing AI / showing enemies in game.
         */
        public function LoopedLevelModel(aLevelEvents: Vector.<LevelEvent>)
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
            while (_levelEvents.length > _currentEventIndex && _levelEvents[_currentEventIndex].distance < _distance)
            {
                levelEvent = _levelEvents[_currentEventIndex];

                if (levelEvent.id == LevelEvent.ID_END)
                {
                    _currentEventIndex = 0;
                    _distance = 0;
                }
                else
                {
                    _levelEventSignal.dispatch(levelEvent);
                    _currentEventIndex++;
                }
            }

        }


    }
}
