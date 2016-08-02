package game.model.gameObject.eventbus.events
{
    import game.model.GameObject;
    import game.model.gameObject.eventbus.*;

    public class DiedEvent extends GameObjectEvent
    {
        private var _hitter: GameObject;

        public function DiedEvent(aHitter: GameObject, aGameObject: GameObject)
        {
            _hitter = aHitter;
            super(aGameObject);
        }

        public function get hitter(): GameObject
        {
            return _hitter;
        }
    }
}
