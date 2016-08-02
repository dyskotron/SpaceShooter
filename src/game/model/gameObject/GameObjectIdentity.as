package game.model.gameObject
{
    public class GameObjectIdentity
    {
        private var _gameObjectID: uint;
        private var _gameObjectGroup: uint;

        //group specific values
        private var _concreteTypeID: uint;
        private var _concreteID: uint;
        private var _owner: GameObjectIdentity;

        /**
         *
         * @param aGameObjectID
         * @param aGameObjectGroup - e.g. enemy, bullet, obstacle, player ship @see game.model.gameObject.constants.GameObjectGroupID
         * @param aConcreteTypeID - enemyType, BulletType...
         * @param aConcreteID - enemyID, bulletID etc..
         * @param aOwner - owner identity
         */
        public function GameObjectIdentity(aGameObjectID: uint, aGameObjectGroup: uint, aConcreteTypeID: uint, aConcreteID: uint, aOwner: GameObjectIdentity = null)
        {
            _gameObjectID = aGameObjectID;
            _gameObjectGroup = aGameObjectGroup;
            _concreteTypeID = aConcreteTypeID;
            _concreteID = aConcreteID;
            _owner = aOwner;
        }

        public function get gameObjectID(): uint
        {
            return _gameObjectID;
        }

        public function get gameObjectGroup(): uint
        {
            return _gameObjectGroup;
        }

        public function get concreteTypeID(): uint
        {
            return _concreteTypeID;
        }

        public function get concreteID(): uint
        {
            return _concreteID;
        }

        public function get owner(): GameObjectIdentity
        {
            return _owner;
        }
    }
}
