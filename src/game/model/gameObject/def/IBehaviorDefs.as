package game.model.gameObject.def
{
    import game.model.gameObject.vo.BehaviorVO;

    public interface IBehaviorDefs
    {
        function getBehaviorVO(aEnemyType: uint): BehaviorVO
    }
}
