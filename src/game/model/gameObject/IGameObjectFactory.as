package game.model.gameObject
{
    import game.model.GameObject;
    import game.model.gameObject.components.fsm.ITarget;
    import game.model.gameObject.components.fsm.ITargetProvider;
    import game.model.gameObject.vo.BehaviorVO;
    import game.model.gameObject.vo.EnemyVO;
    import game.model.playerModel.PlayerShipBuildVO;

    public interface IGameObjectFactory
    {
        function createEnemyShipGO(aEnemyVO: EnemyVO, aBehaviorVO: BehaviorVO, aTargetProvider: ITargetProvider, aX: Number, aY: Number, aTarget: ITarget): GameObject

        function createPlayerShipGO(aPlayerID: uint, aShipBuild: PlayerShipBuildVO, aTargetProvider: ITargetProvider): GameObject
    }
}
