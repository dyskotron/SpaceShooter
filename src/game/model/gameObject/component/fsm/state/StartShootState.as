package game.model.gameObject.component.fsm.state
{
    import game.model.GameObject;
    import game.model.gameObject.component.control.WeaponControlComponent;
    import game.model.gameObject.component.fsm.*;

    public class StartShootState implements IEnemyState
    {
        private var _weaponControlComponent: WeaponControlComponent;

        public function StartShootState()
        {

        }

        public function start(aEnemyGO: GameObject, aTarget: ITarget): void
        {
            _weaponControlComponent = WeaponControlComponent(aEnemyGO.getComponent(WeaponControlComponent));

        }

        public function update(aDeltaTime: Number): uint
        {
            if (_weaponControlComponent != null)
                _weaponControlComponent.startShoot();

            return FSMComponent.ACTION_NEXT;
        }
    }
}
