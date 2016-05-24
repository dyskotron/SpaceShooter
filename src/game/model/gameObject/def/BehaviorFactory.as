package game.model.gameObject.def
{
    import game.model.gameObject.fsm.ITarget;
    import game.model.gameObject.fsm.state.FlyThroughState;
    import game.model.gameObject.fsm.state.GetToPosState;
    import game.model.gameObject.fsm.state.GetToXposState;
    import game.model.gameObject.fsm.state.GetToYposState;
    import game.model.gameObject.fsm.state.KamikazeChaseState;
    import game.model.gameObject.fsm.state.KamikazeStraightState;
    import game.model.gameObject.fsm.state.StopState;
    import game.model.gameObject.fsm.state.WaitState;
    import game.model.gameObject.fsm.state.WobbleState;
    import game.model.gameObject.vo.BehaviorVO;

    public class BehaviorFactory implements IBehaviorFactory
    {
        public static const FLY_THROUGH: uint = 0;
        public static const GET_TO_POS: uint = 1;
        public static const GET_TO_X: uint = 2;
        public static const GET_TO_Y: uint = 3;
        public static const KAMIKAZE_STARIGHT: uint = 4;
        public static const KAMIKAZE_CHASE: uint = 5;
        public static const WOBBLE: uint = 6;

        public function BehaviorFactory()
        {

        }

        public function getBehaviorVO(aBehaviorID: uint, aTarget: ITarget = null): BehaviorVO
        {
            var behaviourVO: BehaviorVO = new BehaviorVO();

            switch (aBehaviorID)
            {
                case FLY_THROUGH:
                    behaviourVO.addState(new FlyThroughState());
                    break;
                case GET_TO_POS:
                    behaviourVO.addState(new GetToPosState(aTarget));
                    behaviourVO.addState(new StopState());
                    break;
                case GET_TO_X:
                    behaviourVO.addState(new GetToXposState(aTarget));
                    behaviourVO.addState(new StopState());
                    break;
                case GET_TO_Y:
                    behaviourVO.addState(new GetToYposState(aTarget));
                    behaviourVO.addState(new StopState());
                    break;
                case KAMIKAZE_STARIGHT:
                    behaviourVO.addState(new GetToYposState(aTarget));
                    behaviourVO.addState(new WaitState(1000));
                    behaviourVO.addState(new KamikazeStraightState());
                    break;
                case KAMIKAZE_CHASE:
                    behaviourVO.addState(new GetToYposState(aTarget));
                    behaviourVO.addState(new WaitState(1000));
                    behaviourVO.addState(new KamikazeChaseState());
                    break;
                case WOBBLE:
                    behaviourVO.addState(new WobbleState());
                    break;
                default:
                    throw new Error("There is no behavior with ID: " + aBehaviorID)

            }

            return behaviourVO;
        }
    }
}
