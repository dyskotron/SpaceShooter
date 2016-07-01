package game.model.gameObject
{
    public class GameObjectIdentity
    {
        private var _gameObjectID: uint;
        private var _gameObjectGroup: uint;

        //group specific values
        private var _concreteTypeID: uint;
        private var _concreteID: uint;
        private var _ownerID: int;

        /**
         *
         * @param aGameObjectID
         * @param aGameObjectGroup - e.g. enemy, bullet, obstacle, player ship @see game.model.gameObject.goDef.GameObjectGroupID
         * @param aConcreteTypeID
         * @param aConcreteID
         */
        public function GameObjectIdentity(aGameObjectID: uint, aGameObjectGroup: uint, aConcreteTypeID: uint, aConcreteID: uint, aOwnerID: int = -1)
        {
            _gameObjectID = aGameObjectID;
            _gameObjectGroup = aGameObjectGroup;
            _concreteTypeID = aConcreteTypeID;
            _concreteID = aConcreteID;
            _ownerID = aOwnerID;
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

        public function get ownerID(): int
        {
            return _ownerID;
        }
    }
}
