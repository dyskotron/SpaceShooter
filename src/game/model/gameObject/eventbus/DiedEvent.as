package game.model.gameObject.eventbus
{
    import game.model.GameObject;

    public class DiedEvent extends GameObjectEvent
    {
        private var _damage: Number;

        public function DiedEvent(aGameObject: GameObject)
        {
            super(aGameObject);
        }
    }
}
