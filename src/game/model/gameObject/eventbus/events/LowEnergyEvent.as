package game.model.gameObject.eventbus.events
{
    import game.model.GameObject;
    import game.model.gameObject.eventbus.*;

    public class LowEnergyEvent extends GameObjectEvent
    {
        public function LowEnergyEvent(aGameObject: GameObject)
        {
            super(aGameObject);
        }

    }
}
