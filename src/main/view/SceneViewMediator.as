package main.view
{
    import main.controller.SceneReadySignal;
    import main.controller.SceneReadyVO;

    import org.robotlegs.mvcs.StarlingMediator;

    public class SceneViewMediator extends StarlingMediator
    {

        [Inject]
        public var sceneReadySignal: SceneReadySignal;

        /**
         * When overriding this method super.onRegister() in it should be always called
         * because some of RobotlegsFSM states needs to receive this signal to finish transitionIn
         */
        override public function onRegister(): void
        {
            if (viewComponent is SceneView)
                sceneReadySignal.dispatch(new SceneReadyVO(SceneView(viewComponent).sceneID));
            else
                trace("_MO_", this, "Error: view registered to this mediator have to be " + SceneView);
        }
    }
}
