/**
 * Created with IntelliJ IDEA.
 * User: DYSKO
 * Date: 5/18/13
 * Time: 9:11 PM
 * To change this template use File | Settings | File Templates.
 */
package game.model.gameObject
{
    import game.model.gameObject.components.ComponentType;
    import game.model.gameObject.components.collider.SquareColliderComponent;
    import game.model.gameObject.components.control.WeaponControlComponent;
    import game.model.gameObject.components.fsm.GameObjectFSM;
    import game.model.gameObject.components.fsm.ITarget;
    import game.model.gameObject.components.fsm.ITargetProvider;
    import game.model.gameObject.components.health.HealthComponent;
    import game.model.gameObject.components.movement.MovementParamsComponent;
    import game.model.gameObject.components.weapon.ComponentSlot;
    import game.model.gameObject.components.weapon.EnemyWeaponComponent;
    import game.model.gameObject.components.weapon.WeaponModel;
    import game.model.gameObject.vo.BehaviorVO;
    import game.model.gameObject.vo.EnemyVO;

    public class EnemyGO extends ShootingGO
    {
        private var _enemyVO: EnemyVO;

        public function EnemyGO(aEnemyVO: EnemyVO, aBehaviorVO: BehaviorVO, aTargetProvider: ITargetProvider, aX: Number, aY: Number, aTarget: ITarget): void
        {
            super(aEnemyVO, aTargetProvider, aX, aY);

            _enemyVO = aEnemyVO;

            var weaponSlot: ComponentSlot;

            if (aEnemyVO.componentSlots)
            {
                for (var i: int = 0; i < aEnemyVO.componentSlots.length; i++)
                {
                    weaponSlot = aEnemyVO.componentSlots[i];
                    if (weaponSlot.isComponentType(ComponentType.GUNS))
                    {
                        addComponent(new EnemyWeaponComponent(WeaponModel(weaponSlot.componentModel), weaponSlot.x, weaponSlot.y));
                    }
                }
            }

            addComponent(new MovementParamsComponent(aEnemyVO.speed));
            addComponent(new GameObjectFSM(aBehaviorVO.states, aTarget));
            addComponent(new HealthComponent(aEnemyVO.initialHP));
            addComponent(new SquareColliderComponent());
            _weaponControl = new WeaponControlComponent(aTargetProvider);
            addComponent(_weaponControl);

            initComponents();

            _weaponControl.startShoot();
        }

    }
}
