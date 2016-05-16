package common.controller.fsm
{
    import org.osflash.signals.Signal;

    public interface IFSMState
    {
        function get transitionInFinishedSignal(): Signal

        function get transitionOutFinishedSignal(): Signal

        function init(): void;

        function start(): void;

        function transitionIn(): void;

        function transitionOut(): void;

        function destroy(): void;

    }
}
