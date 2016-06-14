package game.controller.playerControl
{
    public interface ITouchController
    {
        function get enabled(): Boolean;

        function set enabled(aEnabled: Boolean): void;

        function get directionChangeSignal(): DirectionChangeSignal;

        function get positionChangeSignal(): PositionChangeSignal;

        function get actionEnableSignal(): ActionEnableSignal;

        function get actionSwitchSignal(): ActionSwitchSignal;
    }
}
