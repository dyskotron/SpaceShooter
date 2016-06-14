package game.model.gameObject.components.physics
{
    import flash.geom.Rectangle;

    public interface IPhysicsComponent
    {
        function get x(): Number;

        function set x(value: Number): void;

        function get y(): Number;

        function set y(value: Number): void;

        function get speedX(): Number;

        function set speedX(value: Number): void;

        function get speedY(): Number;

        function set speedY(value: Number): void;

        function get rotation(): Number;

        function set rotation(value: Number): void;

        function get bounds(): Rectangle;

        function update(deltaTime: int): void;
    }
}
