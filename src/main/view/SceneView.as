package main.view
{
    import starling.display.Sprite;

    public class SceneView extends Sprite
    {
        private var _sceneID: uint;

        /**
         * Base class for all scene views - only direct child of context view, representing main states of game
         * @param aSceneID
         */
        public function SceneView(aSceneID: uint)
        {
            _sceneID = aSceneID;
        }

        public function get sceneID(): uint
        {
            return _sceneID;
        }

        public function destroy(): void
        {

        }
    }
}
