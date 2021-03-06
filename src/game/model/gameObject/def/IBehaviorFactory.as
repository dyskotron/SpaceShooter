package game.model.gameObject.def
{
    import game.model.gameObject.fsm.ITarget;
    import game.model.gameObject.vo.BehaviorVO;

    public interface IBehaviorFactory
    {
        function getBehaviorVO(aEnemyType: uint, aTarget: ITarget = null): BehaviorVO
    }
}
