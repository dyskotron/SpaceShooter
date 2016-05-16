package home.view
{
    import home.controller.StartGameSignal;

    import main.model.IViewModel;
    import main.view.SceneViewMediator;

    public class HomeMediator extends SceneViewMediator
    {

        [Inject]
        public var model: IViewModel;

        [Inject]
        public var view: HomeView;

        [Inject]
        public var startGameSignal: StartGameSignal;

        override public function onRegister(): void
        {
            super.onRegister();

            view.init(model);
        }

    }
}
