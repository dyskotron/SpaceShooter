package home.view
{

    import main.model.IViewModel;
    import main.view.SceneID;
    import main.view.SceneView;

    public class HomeView extends SceneView
    {
        private var _menu: MainMenuView;


        public function HomeView()
        {
            super(SceneID.HOME);
        }

        public function init(model: IViewModel): void
        {
            _menu = new MainMenuView();
            _menu.x = (model.stageWidth - _menu.width) / 2;
            _menu.y = (model.stageHeight - _menu.height) / 2;
            addChild(_menu);
        }
    }
}
