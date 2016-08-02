package game.model.gameObject.component.health
{
    import game.model.GameObject;
    import game.model.gameObject.component.IComponent;

    import org.osflash.signals.Signal;

    public interface IHealthComponent extends IComponent
    {
        function get changeStateSignal(): Signal;

        function get hp(): int;

        function get maxHP(): int

        function get state(): uint;

        function hit(aDamage: Number, aHitter: GameObject): void;

        function addHitPoints(aValue: uint): void;

        function setFullHealth(): void;
    }
}
