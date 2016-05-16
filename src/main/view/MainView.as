package main.view
{

    import enterName.view.EnterNameView;

    import feathers.themes.MetalWorksDesktopTheme;

    import game.view.GameView;

    import highScores.view.HighScoresView;

    import home.view.HomeView;

    import main.MainContext;

    import org.robotlegs.mvcs.StarlingContext;

    import starling.display.Sprite;

    public class MainView extends Sprite
    {

        private var mainContext: StarlingContext;

        private var _scene: SceneView;


        public function MainView()
        {
            mainContext = new MainContext();
            mainContext.contextView = this;

            new MetalWorksDesktopTheme();
        }

        public function set scene(sceneID: uint): void
        {
            var nextScene: SceneView;
            switch (sceneID)
            {
                case SceneID.GAME:
                    nextScene = new GameView();
                    break;
                case SceneID.HOME:
                    nextScene = new HomeView();
                    break;
                case SceneID.HIGH_SCORES:
                    nextScene = new HighScoresView();
                    break;
                case SceneID.ENTER_NAME:
                    nextScene = new EnterNameView();
                    break;
                default:
                    trace("_MO_", this, "Error: scene for ID " + sceneID + " not set");
            }

            //remove old
            if (_scene)
            {
                _scene.destroy();
                removeChild(_scene);
                _scene = null;
            }

            //new
            if (nextScene)
            {
                _scene = nextScene;
                addChild(_scene);
            }

        }
    }
}
