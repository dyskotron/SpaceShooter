package game.model.gameObject.component.identity
{
    import game.model.gameObject.component.Component;

    public class IdentityComponent extends Component
    {
        public var gameObjectID: uint;
        public var gameObjectGroup: uint;
        public var gameObjectGroupSpecificID: uint;
        public var gameObjectType: uint;
    }
}
