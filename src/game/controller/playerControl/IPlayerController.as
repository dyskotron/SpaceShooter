package game.controller.playerControl
{
    public interface IPlayerController
    {
        function get enabled(): Boolean;

        function set enabled(aEnabled: Boolean): void;

        function get directionChangeSignal(): DirectionChangeSignal;

        function get positionChangeSignal(): PositionChangeSignal;

        function get actionSwitchSignal(): ActionSwitchSignal;

        function get actionTriggerSignal(): ActionTriggerSignal;
    }
}
