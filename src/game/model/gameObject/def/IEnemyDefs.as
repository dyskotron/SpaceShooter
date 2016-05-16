package game.model.gameObject.def
{
    import game.model.gameObject.vo.EnemyVO;

    public interface IEnemyDefs
    {
        function getEnemyVO(aEnemyType: uint): EnemyVO;
    }
}
