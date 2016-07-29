package game.model.gameObject.component.effect
{
    public class PropertyEffectVO
    {
        //is set by effect component, used for look up in effects
        public var id: uint;

        public var componentID: uint;
        public var propertyID: uint;

        public var type: uint;
        public var value: Number;
        public var multiGroup: uint
    }
}
