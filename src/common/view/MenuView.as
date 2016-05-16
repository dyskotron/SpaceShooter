package common.view
{
    import common.controller.MenuPressedSignal;

    import starling.display.Sprite;

    public class MenuView extends Sprite
    {
        protected var _menuPressedSignal: MenuPressedSignal;

        public function MenuView()
        {
            _menuPressedSignal = new MenuPressedSignal();
        }

        public function get menuPressedSignal(): MenuPressedSignal
        {
            return _menuPressedSignal;
        }
    }
}
