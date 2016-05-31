package game.model.gameObject.vo
{
    import game.model.generator.GeneratorVO;
    import game.model.weapon.WeaponModel;

    public class PlayerShipVO extends ShootingVO
    {
        private var _generatorVO: GeneratorVO;

        public function PlayerShipVO(aTypeID: uint, aWeapons: Vector.<WeaponModel>, aGeneratorVO: GeneratorVO, aInitialHP: Number, aWidth: Number, aHeight: Number)
        {
            _generatorVO = aGeneratorVO;
            super(aTypeID, aWeapons, aInitialHP, aWidth, aHeight);
        }

        public function get generatorVO(): GeneratorVO
        {
            return _generatorVO;
        }
    }
}
