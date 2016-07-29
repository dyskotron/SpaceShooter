package game.model.gameObject.component.effect
{
    public class ComponentTypeID
    {
        public static const MOVE: uint = 0;
        public static const MOVE_PARAMS: uint = 1;
        public static const HEALTH: uint = 2;
        public static const WEAPON_CONTROL: uint = 3;
        public static const FSM: uint = 4;
        public static const GENERATOR: uint = 5;

        public static const NUM_TYPES: uint = GENERATOR - 1;
    }
}
