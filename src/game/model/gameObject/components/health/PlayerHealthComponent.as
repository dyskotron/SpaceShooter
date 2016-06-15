package game.model.gameObject.components.health
{
    import com.greensock.TweenLite;

    import game.model.GameObject;
    import game.model.gameObject.PlayerShipGO;

    public class PlayerHealthComponent extends HealthComponent
    {
        private var _lives: int;
        private var _playerGO: PlayerShipGO;

        public function PlayerHealthComponent(aMaxHP: int, aLives: int = 1)
        {
            super(aMaxHP);
            _lives = aLives;

        }

        //region GETTERS & SETTERS

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
            _playerGO = PlayerShipGO(aGameObject);
            _state = PlayerShipGO.STATE_ALIVE;

            super.init(aGameObject);
        }

        override public function hit(aDamage: Number): void
        {
            super.hit(aDamage);
            if (hp <= 0)
                die();

            _playerGO.statsUpdateSignal.dispatch();
        }

        private function die(): void
        {
            _lives = Math.max(--_lives, 0);
            _playerGO.weaponsOnDeath();

            if (_lives > 0)
            {
                _state = PlayerShipGO.STATE_WAITING;
                TweenLite.delayedCall(1, spawn);
            }
            else
            {
                _state = PlayerShipGO.STATE_DEAD;
            }
            changeStateSignal.dispatch(this);
        }

        private function spawn(): void
        {
            _state = PlayerShipGO.STATE_SPAWNING;
            TweenLite.delayedCall(1.5, setAlive);
            changeStateSignal.dispatch(this);
        }

        private function setAlive(): void
        {
            _state = PlayerShipGO.STATE_ALIVE;
            setFullHealth();

            changeStateSignal.dispatch(this);
            _playerGO.statsUpdateSignal.dispatch();

            if (_playerGO.isShooting)
                _playerGO.startShoot();
        }

        /*
         private function dispatchChangeState(): void
         {
         changeStateSignal.dispatch(this);
         } */
    }
}
