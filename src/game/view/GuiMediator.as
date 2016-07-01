package game.view
{
    import common.model.TextureProvider;

    import game.controller.ViewUpdateSignal;

    import main.model.IMainModel;

    import org.robotlegs.mvcs.StarlingMediator;

    public class GuiMediator extends StarlingMediator
    {

        [Inject]
        public var textureProvider: TextureProvider;

        [Inject]
        public var guiView: GuiView;

        [Inject]
        public var viewUpdateSignal: ViewUpdateSignal;

        [Inject]
        public var mainModel: IMainModel;

        override public function onRegister(): void
        {
            guiView.init(textureProvider, mainModel);
            viewUpdateSignal.add(viewUpdateHandler);
        }

        override public function onRemove(): void
        {
            viewUpdateSignal.remove(viewUpdateHandler);
        }

        private function viewUpdateHandler(aDeltaTime: int): void
        {
            guiView.update();
        }
    }
}
