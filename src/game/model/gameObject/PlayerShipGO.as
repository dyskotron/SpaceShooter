/**
 * Created with IntelliJ IDEA.
 * User: DYSKO
 * Date: 5/18/13
 * Time: 9:11 PM
 * To change this template use File | Settings | File Templates.
 */
package game.model.gameObject
{
    import game.model.gameObject.components.collider.IColliderComponent;
    import game.model.gameObject.components.health.IHealthComponent;
    import game.model.gameObject.components.weapon.ComponentSlot;
    import game.model.gameObject.components.weapon.IWeaponComponent;
    import game.model.gameObject.fsm.ITargetProvider;
    import game.model.gameObject.vo.PlayerShipVO;

    public class PlayerShipGO extends ShootingGO
    {
        public function PlayerShipGO(aPlayerShipVO: PlayerShipVO, aTargetProvider: ITargetProvider): void
        {
            super(aPlayerShipVO, aTargetProvider, 0, 0, 0, 0);
        }

        override protected function mountComponents(): void
        {
            //do nothing
        }

        override protected function createHealthComponent(aInitialHP: int): IHealthComponent
        {
            return null;
        }

        override protected function createWeapon(aComponentSLot: ComponentSlot): IWeaponComponent
        {
            return null;
        }

        override protected function createCollider(): IColliderComponent
        {
            return null;
        }


    }
}
