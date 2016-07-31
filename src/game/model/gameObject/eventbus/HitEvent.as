package game.model.gameObject.eventbus
{
    import game.model.GameObject;

    public class HitEvent extends GameObjectEvent
    {
        private var _damage: Number;

        public function HitEvent(aDamage: Number, aGameObject:GameObject)
        {
            _damage = aDamage;
            super(aGameObject);
        }

        public function get damage(): Number
        {
            return _damage;
        }
    }
}
