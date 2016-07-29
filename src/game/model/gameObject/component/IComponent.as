package game.model.gameObject.component
{
    import game.model.GameObject;
    import game.model.gameObject.component.effect.property.EffectableProperty;

    public interface IComponent
    {
        function get active(): Boolean;

        function set active(value: Boolean): void;

        function get maxLifeTime(): Number;

        function set maxLifeTime(value: Number): void;

        function get lifeTime(): Number;

        function get gameObject(): GameObject;

        function init(aGameObject: GameObject): void

        function update(deltaTime: Number): void

        function terminate(): void

        function getProperty(aPropertyID: uint): EffectableProperty

        function destroy(): void;
    }
}
