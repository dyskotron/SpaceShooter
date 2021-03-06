/**
 * Created with IntelliJ IDEA.
 * User: DYSKO
 * Date: 5/18/13
 * Time: 9:11 PM
 * To change this template use File | Settings | File Templates.
 */
package game.model.gameObject
{
    import game.model.gameObject.components.weapon.ComponentSlot;
    import game.model.gameObject.components.weapon.EnemyWeaponComponent;
    import game.model.gameObject.components.weapon.IWeaponComponent;
    import game.model.gameObject.components.weapon.WeaponModel;
    import game.model.gameObject.fsm.GameObjectFSM;
    import game.model.gameObject.fsm.ITarget;
    import game.model.gameObject.fsm.ITargetProvider;
    import game.model.gameObject.vo.BehaviorVO;
    import game.model.gameObject.vo.EnemyVO;

    import org.osflash.signals.Signal;

    public class EnemyGO extends ShootingGO
    {
        private var _enemyVO: EnemyVO;

        private var _fsm: GameObjectFSM;

        public function EnemyGO(aEnemyVO: EnemyVO, aBehaviorVO: BehaviorVO, aTargetProvider: ITargetProvider, aX: Number, aY: Number, aTarget: ITarget): void
        {
            super(aEnemyVO, aTargetProvider, aX, aY, 0, 0);

            _enemyVO = aEnemyVO;

            _fsm = new GameObjectFSM(aBehaviorVO.states, this, aTarget);

            startShoot();
        }

        public function get enemyVO(): EnemyVO
        {
            return _enemyVO;
        }

        override public function update(aDeltaTime: int): void
        {
            _fsm.update(this, aDeltaTime);
            _fsm.curentState.update(this, aDeltaTime);

            super.update(aDeltaTime);
        }

        override public function destroy(): void
        {

        }

        override protected function createWeapon(aShootSignal: Signal, aComponentSlot: ComponentSlot): IWeaponComponent
        {
            return new EnemyWeaponComponent(aShootSignal, WeaponModel(aComponentSlot.componentModel), 100, _targetProvider, aComponentSlot.x, aComponentSlot.y);
        }

    }
}
