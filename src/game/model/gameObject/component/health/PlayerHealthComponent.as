package game.model.gameObject.component.health
{
    import com.greensock.TweenLite;

    import game.model.GameObject;
    import game.model.gameObject.component.control.WeaponControlComponent;

    public class PlayerHealthComponent extends HealthComponent
    {
        private var _lives: int;
        private var _weaponControl: WeaponControlComponent;

        public function PlayerHealthComponent(aMaxHP: int, aLives: int = 1)
        {
            super(aMaxHP);
            _lives = aLives;

        }

        //region ========================================= GETTERS & SETTERS ===========================================

        public function get lives(): int
        {
            return _lives;
        }

        public function set lives(value: int): void
        {
            _lives = value;
        }

        //endregion

        override public function init(aGameObject: GameObject): void
        {
            super.init(aGameObject);

            _state = HealthState.ALIVE;
            _weaponControl = WeaponControlComponent(gameObject.getComponent(WeaponControlComponent));
        }

        override public function hit(aDamage: Number): void
        {
            super.hit(aDamage);
            if (hp <= 0)
                die();
        }

        private function die(): void
        {
            _lives = Math.max(--_lives, 0);
            _weaponControl.weaponsOnDeath();

            if (_lives > 0)
            {
                _state = HealthState.WAITING;
                TweenLite.delayedCall(1, spawn);
            }
            else
            {
                _state = HealthState.DEAD;
            }
            changeStateSignal.dispatch(this);
        }

        private function spawn(): void
        {
            _state = HealthState.SPAWNING;
            TweenLite.delayedCall(1.5, setAlive);
            changeStateSignal.dispatch(this);
        }

        private function setAlive(): void
        {
            _state = HealthState.ALIVE;
            setFullHealth();

            changeStateSignal.dispatch(this);

            if (_weaponControl.isShooting)
                _weaponControl.startShoot();
        }
    }
}
