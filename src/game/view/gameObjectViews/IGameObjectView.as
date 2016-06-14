package game.view.gameObjectViews
{
    public interface IGameObjectView
    {
        function hitAnim(): void;

        function get x(): Number;

        function set x(value: Number): void;

        function get y(): Number;

        function set y(value: Number): void;

        function get rotation(): Number;

        function set rotation(value: Number): void;

        function get color(): uint;

        function set color(value: uint): void;

        function remove(): void;
    }
}
