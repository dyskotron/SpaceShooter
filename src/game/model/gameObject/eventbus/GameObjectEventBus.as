package game.model.gameObject.eventbus
{
    import flash.utils.Dictionary;

    public class GameObjectEventBus
    {
        private var _listeners: Dictionary;

        public function GameObjectEventBus()
        {
            _listeners = new Dictionary();
        }

        public function addListener(aEventType: Class, aListener: Function)
        {
            _listeners[aEventType] ||= new Vector.<Function>();
            _listeners[aEventType].push(aListener);
        }

        public function removeListener(aEventType: Class, aListener: Function)
        {
            var listeners: Vector.<Function> = _listeners[aEventType];
            if (!listeners)
                return;

            for (var i: int = 0; i < listeners.length; i++)
            {
                if (listeners[i] == aListener)
                {
                    listeners.splice(i, 1);
                    return;
                }
            }
        }

        public function fireEvent(aEvent: GameObjectEvent)
        {
            var eventClass: Class = Object(aEvent).constructor;

            var listeners: Vector.<Function> = _listeners[eventClass];
            if (!listeners)
                return;

            for (var i: int = 0; i < listeners.length; i++)
            {
                listeners[i](aEvent);
            }
        }
    }
}
