package game.model.gameObject
{
    import game.model.GameObject;
    import game.model.gameObject.component.fsm.ITarget;
    import game.model.gameObject.component.fsm.ITargetProvider;
    import game.model.gameObject.vo.BehaviorVO;
    import game.model.gameObject.vo.BonusVO;
    import game.model.gameObject.vo.BulletVO;
    import game.model.gameObject.vo.EnemyVO;
    import game.model.gameObject.vo.ObstacleVO;
    import game.model.playerModel.PlayerShipBuildVO;

    public interface IGameObjectFactory
    {
        function createEnemyShipGO(aEnemyVO: EnemyVO, aBehaviorVO: BehaviorVO, aTargetProvider: ITargetProvider, aTarget: ITarget): GameObject;

        function createPlayerShipGO(aPlayerID: uint, aShipBuild: PlayerShipBuildVO, aTargetProvider: ITargetProvider): GameObject;

        function createBonusGO(aBonusVO: BonusVO, aSpeedY: Number): GameObject;

        function createObstacleGO(aObstacleVO: ObstacleVO, aSpeedX: Number, aSpeedY: Number, aRotation: Number): GameObject;

        function createBulletGO(aBulletVO: BulletVO, aOwnerID: int, aSpeed: Number, aAngle: Number, aTargetProvider: ITargetProvider): GameObject;
    }
}
