package game.model.gameObject.components
{
    import game.model.GameObject;

    public interface IComponent
    {
        function get enabled(): Boolean;

        function set enabled(value: Boolean): void;

        function get gameObject(): GameObject;

        function init(aGameObject: GameObject): void

        function update(deltaTime: int): void
    }
}
