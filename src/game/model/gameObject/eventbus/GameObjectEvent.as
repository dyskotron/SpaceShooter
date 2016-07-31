package game.model.gameObject.eventbus
{
    import game.model.GameObject;

    public class GameObjectEvent
    {
        private var _gameObject: GameObject;

        public function GameObjectEvent(aGameObject: GameObject)
        {
            _gameObject = aGameObject;
        }

        public function get gameObject(): GameObject
        {
            return _gameObject;
        }
    }
}
