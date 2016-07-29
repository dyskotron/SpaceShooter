package game.model.gameObject.component
{
    public interface IContainer
    {
        function addComponent(component: IComponent): void;

        function removeComponent(component: IComponent): void;

        function removeComponentAt(index: int): void;
    }
}
