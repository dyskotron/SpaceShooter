package game.model.gameObject.components.health
{
    import game.model.gameObject.components.IComponent;

    import org.osflash.signals.Signal;

    public interface IHealthComponent extends IComponent
    {
        function get changeStateSignal(): Signal;

        function get hp(): int;

        function get state(): uint;

        function hit(aDamage: Number): void;

        function addHitPoints(aValue: uint): void;

        function setFullHealth(): void;
    }
}
