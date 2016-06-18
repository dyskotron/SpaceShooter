package game.model.gameObject.components.identity
{
    import game.model.gameObject.components.Component;

    public class IdentityComponent extends Component
    {
        public var gameObjectID: uint;
        public var gameObjectGroup: uint;
        public var gameObjectGroupSpecificID: uint;
        public var gameObjectType: uint;
    }
}
