package game.model.gameObject.components.fsm
{
    public interface ITargetProvider
    {
        function getTarget(aTargetType: uint, aX: Number = 0, aY: Number = 0, aOrigAngle: Number = 0): ITarget;
    }
}
