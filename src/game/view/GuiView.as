package game.view
{
    import common.model.TextureProvider;

    import feathers.controls.Label;
    import feathers.controls.LayoutGroup;
    import feathers.controls.ProgressBar;
    import feathers.layout.HorizontalLayout;

    import game.model.GameObject;
    import game.model.gameObject.component.control.WeaponControlComponent;
    import game.model.gameObject.component.generator.IGeneratorComponent;
    import game.model.gameObject.component.health.PlayerHealthComponent;
    import game.model.playerModel.IPlayerModel;

    import main.model.IMainModel;

    import starling.display.DisplayObjectContainer;
    import starling.display.Image;
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.utils.Color;

    public class GuiView extends DisplayObjectContainer
    {
        private static const MARGIN: Number = 4;
        private static const LABEL_MARGIN: Number = 10;

        private var _height: Number;
        private var _width: Number;

        private var _scoreLabel: Label;
        private var _playerGO: GameObject;
        private var _hpDisplay: ProgressBar;
        private var _energyDisplay: ProgressBar;
        private var _layoutGroup: LayoutGroup;
        private var _livesLabel: Label;
        private var _weaponPowerLabel: Label;

        private var _playerHealth: PlayerHealthComponent;
        private var _playerGenerator: IGeneratorComponent;
        private var _playerWeapons: WeaponControlComponent;
        private var _playerModel: IPlayerModel;

        /**
         * View for player stats e.g. lives, hp, weapon power etc
         * @param aPlayerGO
         * @param aWidth
         * @param aHeight
         */
        public function GuiView(aPlayerGO: GameObject, aWidth: Number, aHeight: Number)
        {
            _height = aHeight;
            _width = aWidth;
            _playerGO = aPlayerGO;

            _playerHealth = PlayerHealthComponent(_playerGO.getComponent(PlayerHealthComponent));
            _playerGenerator = IGeneratorComponent(_playerGO.getComponent(IGeneratorComponent));
            _playerWeapons = WeaponControlComponent(_playerGO.getComponent(WeaponControlComponent));
        }

        override public function get height(): Number
        {
            return _height;
        }

        override public function get width(): Number
        {
            return _width;
        }

        public function init(aTextureProvider: TextureProvider, aMainModel: IMainModel): void
        {
            _playerModel = aMainModel.getPlayerModel(_playerGO.identity.concreteID);

            var innerHeight: Number = height - 2 * MARGIN;

            var bg: Quad = new Quad(_width - MARGIN, _height - MARGIN, Color.GRAY);
            bg.x = bg.y = MARGIN / 2;
            addChild(bg);

            var layout: HorizontalLayout = new HorizontalLayout();
            layout.gap = 10;
            _layoutGroup = new LayoutGroup();
            _layoutGroup.layout = layout;
            _layoutGroup.height = innerHeight;
            _layoutGroup.y = MARGIN;
            addChild(_layoutGroup);

            var layoutChildren: Vector.<Sprite> = new Vector.<Sprite>();

            //gun power
            var weaponPowerContainer: Sprite = new Sprite();

            var weaponPowerIcon: Image = new Image(aTextureProvider.getWeaponPowerIconTexture());
            weaponPowerIcon.y = (innerHeight - weaponPowerIcon.height) / 2;
            weaponPowerContainer.addChild(weaponPowerIcon);

            _weaponPowerLabel = new Label();
            _weaponPowerLabel.y = LABEL_MARGIN;
            _weaponPowerLabel.x = weaponPowerIcon.width + MARGIN * 4;
            _weaponPowerLabel.width = 30;
            weaponPowerContainer.addChild(_weaponPowerLabel);

            layoutChildren.push(weaponPowerContainer);

            //lives
            var livesContainer: Sprite = new Sprite();

            var livesIcon: Image = new Image(aTextureProvider.getPlayerLifeIconTexture(_playerGO.identity.gameObjectID));
            livesIcon.y = (innerHeight - livesIcon.height) / 2;
            livesContainer.addChild(livesIcon);

            _livesLabel = new Label();
            _livesLabel.y = LABEL_MARGIN;
            _livesLabel.x = livesIcon.width + MARGIN * 4;
            _livesLabel.width = 30;
            livesContainer.addChild(_livesLabel);

            layoutChildren.push(livesContainer);

            //hit points + energy
            var hpEnergyContainer: Sprite = new Sprite();
            _hpDisplay = new ProgressBar();
            _hpDisplay.value = _hpDisplay.maximum = _playerHealth.maxHP;
            _hpDisplay.width = width / 4;
            _hpDisplay.height = innerHeight / 2;
            hpEnergyContainer.addChild(_hpDisplay);

            _energyDisplay = new ProgressBar();
            _energyDisplay.value = _energyDisplay.maximum = _playerGenerator.capacity;
            _energyDisplay.y = innerHeight / 2;
            _energyDisplay.width = width / 4;
            _energyDisplay.height = innerHeight / 2;
            hpEnergyContainer.addChild(_energyDisplay);

            layoutChildren.push(hpEnergyContainer);

            //score
            var scoreContainer: Sprite = new Sprite();

            _scoreLabel = new Label();
            _scoreLabel.width = width / 2;
            _scoreLabel.height = innerHeight;
            _scoreLabel.y = LABEL_MARGIN;
            scoreContainer.addChild(_scoreLabel);

            layoutChildren.push(scoreContainer);

            //add to layout group
            for (var i: int = 0; i < layoutChildren.length; i++)
            {
                _layoutGroup.addChild(layoutChildren[i]);
            }

            update();
        }

        public function update(): void
        {
            _energyDisplay.value = _playerGenerator.energy;
            _weaponPowerLabel.text = String(_playerWeapons.weaponPower);
            _livesLabel.text = String(_playerHealth.lives);
            _hpDisplay.value = _playerHealth.hp;
            _scoreLabel.text = "score: " + _playerModel.score;
        }
    }
}
