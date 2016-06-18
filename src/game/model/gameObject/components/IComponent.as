package game.model.gameObject.components
{
    import game.model.GameObject;

    public interface IComponent
    {
        function get active(): Boolean;

        function set active(value: Boolean): void;

        function get gameObject(): GameObject;

        function init(aGameObject: GameObject): void

        function update(deltaTime: int): void
    }
}
