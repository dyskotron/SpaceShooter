package game.model.gameObject.fsm
{
    public interface ITarget
    {
        function get x(): Number;

        function get y(): Number;

        function getAngleFromCoords(aX: Number, aY: Number): Number;

        function getAngleDelta(aX: Number, aY: Number, aAngle: Number): Number;

        function getDistanceSq(aX: Number, aY: Number): Number;
    }
}
