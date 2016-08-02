package game.model.gameObject.eventbus.events
{
    import game.model.GameObject;
    import game.model.gameObject.eventbus.*;

    public class HitEvent extends GameObjectEvent
    {
        private var _damage: Number;
        private var _hitter: GameObject;

        public function HitEvent(aDamage: Number, aHitter: GameObject, aGameObject: GameObject)
        {
            _damage = aDamage;
            _hitter = aHitter;
            super(aGameObject);
        }

        public function get damage(): Number
        {
            return _damage;
        }

        public function get hitter(): GameObject
        {
            return _hitter;
        }
    }
}
