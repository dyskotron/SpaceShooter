/**
 * Created with IntelliJ IDEA.
 * User: DYSKO
 * Date: 5/18/13
 * Time: 9:11 PM
 * To change this template use File | Settings | File Templates.
 */
package game.model.gameObject
{
    import game.model.gameObject.components.fsm.ITargetProvider;
    import game.model.gameObject.vo.PlayerShipVO;

    public class PlayerShipGO extends ShootingGO
    {
        public function PlayerShipGO(aPlayerShipVO: PlayerShipVO, aTargetProvider: ITargetProvider): void
        {
            super(aPlayerShipVO, aTargetProvider, 0, 0);
        }
    }
}
