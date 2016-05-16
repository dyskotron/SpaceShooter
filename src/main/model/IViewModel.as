package main.model
{
    import starling.display.Stage;

    public interface IViewModel
    {
        function get stage(): Stage;

        function get gameWidth(): Number;

        function get gameHeight(): Number;

        function get stageWidth(): Number;

        function get stageHeight(): Number;

        function init(aStage: Stage): void;
    }
}
