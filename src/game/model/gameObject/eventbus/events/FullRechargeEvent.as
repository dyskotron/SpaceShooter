package game.model.gameObject.eventbus.events
{
    import game.model.GameObject;
    import game.model.gameObject.eventbus.*;

    public class FullRechargeEvent extends GameObjectEvent
    {
        public function FullRechargeEvent(aGameObject: GameObject)
        {
            super(aGameObject);
        }

    }
}
