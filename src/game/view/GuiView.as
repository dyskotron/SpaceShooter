package game.view
{
    import common.model.TextureProvider;

    import feathers.controls.Label;
    import feathers.controls.LayoutGroup;
    import feathers.controls.ProgressBar;
    import feathers.core.FeathersControl;
    import feathers.layout.HorizontalLayout;

    import game.model.gameObject.PlayerShipGO;

    import main.model.IViewModel;

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
        private var _playerID: Number;
        private var _hpDisplay: ProgressBar;
        private var _layoutGroup: LayoutGroup;
        private var _livesLabel: Label;
        private var _weaponPowerLabel: Label;

        /**
         * View for player stats e.g. lives, hp, weapon power etc
         * @param aPlayerID
         * @param aWidth
         * @param aHeight
         */
        public function GuiView(aPlayerID: Number, aWidth: Number, aHeight: Number)
        {
            _height = aHeight;
            _width = aWidth;
            _playerID = aPlayerID;
        }

        override public function get height(): Number
        {
            return _height;
        }

        override public function get width(): Number
        {
            return _width;
        }

        public function get playerID(): Number
        {
            return _playerID;
        }

        public function init(aViewModel: IViewModel, aPlayerModel: PlayerShipGO, aTextureProvider: TextureProvider): void
        {
            var innerHeight: Number = height - 2 * MARGIN;

            var bg: Quad = new Quad(_width - MARGIN, _height - MARGIN, Color.GRAY);
            bg.x = bg.y = MARGIN / 2;
            addChild(bg);

            var layout: HorizontalLayout = new HorizontalLayout();
            layout.gap = 10;
            _layoutGroup = new LayoutGroup();
            _layoutGroup.layout = layout;
            _layoutGroup.height = innerHeight
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

            var livesIcon: Image = new Image(aTextureProvider.getPlayerLifeIconTexture(_playerID));
            livesIcon.y = (innerHeight - livesIcon.height) / 2;
            livesContainer.addChild(livesIcon);

            _livesLabel = new Label();
            _livesLabel.y = LABEL_MARGIN;
            _livesLabel.x = livesIcon.width + MARGIN * 4;
            _livesLabel.width = 30;
            livesContainer.addChild(_livesLabel);

            layoutChildren.push(livesContainer);

            //hit points
            _hpDisplay = new ProgressBar();
            _hpDisplay.value = _hpDisplay.maximum = aPlayerModel.playerShipVO.initialHP;
            _hpDisplay.width = width / 4;
            _hpDisplay.height = innerHeight;
            layoutChildren.push(_hpDisplay);

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

            update(aPlayerModel);
        }

        public function update(aPlayerModel: PlayerShipGO): void
        {
            _weaponPowerLabel.text = String(aPlayerModel.weaponPower);
            _livesLabel.text = String(aPlayerModel.lives);
            _hpDisplay.value = aPlayerModel.hp;
            _scoreLabel.text = "score: " + aPlayerModel.score;
        }

        private function addLayoutChild(aChild: FeathersControl): void
        {
            _layoutGroup.addChild(aChild);

        }
    }
}
