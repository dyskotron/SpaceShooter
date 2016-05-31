package game.model.gameObject.def
{
    import game.model.gameObject.vo.BulletVO;

    public interface IBulletDefs
    {
        function getBulletVO(aBulletType: uint): BulletVO;
    }
}
