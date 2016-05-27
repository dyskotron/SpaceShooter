package game.model.weapon
{
    import game.model.gameObject.BulletGO;
    import game.model.gameObject.constants.BulletType;
    import game.model.gameObject.vo.BulletVO;

    import org.osflash.signals.Signal;

    public class PlayerWeapon extends Weapon
    {
        private var _displayedPower: uint = WEAPON_MIN;

        public function PlayerWeapon(aShootSignal: Signal, aShootInterval: int, aX: Number = 0, aY: Number = 0)
        {
            super(aShootSignal, aShootInterval, aX, aY);
        }

        override public function startShoot(): void
        {
            super.startShoot();
            _nextShotTime = 0;
        }

        public function addPower(): void
        {
            _displayedPower = Math.min(++_displayedPower, WEAPON_MAX);
        }

        public function onDeath(): void
        {
            _displayedPower = Math.max(Math.floor(_displayedPower / 2), WEAPON_MIN);
            stopShoot();
        }

        public function get displayedPower(): uint
        {
            if (_displayedPower == 10)
                return 7;
            else if (_displayedPower > 6)
                return 6;

            return _displayedPower;
        }

        override protected function shoot(aX: Number, aY: Number): void
        {
            var bullets: Vector.<BulletGO> = new Vector.<BulletGO>();
            var bulletVO: BulletVO = new BulletVO(BulletType.LASER, 10, 4, 10);

            switch (_displayedPower)
            {
                case 1:
                    bullets.push(new BulletGO(_ownerID, bulletVO, aX, aY - 40, 0, -0.6));
                    break;
                case 2:
                    bullets.push(new BulletGO(_ownerID, bulletVO, aX + 3, aY - 40, 0, -0.6));
                    bullets.push(new BulletGO(_ownerID, bulletVO, aX - 3, aY - 40, 0, -0.6));
                    break;
                case 3:
                    bullets.push(new BulletGO(_ownerID, bulletVO, aX, aY - 40, 0, -0.6));
                    bullets.push(new BulletGO(_ownerID, bulletVO, aX - 45, aY - 25, -0.1, -0.6));
                    bullets.push(new BulletGO(_ownerID, bulletVO, aX + 45, aY - 25, 0.1, -0.6));
                    break;

                case 4:
                    bullets.push(new BulletGO(_ownerID, bulletVO, aX + 3, aY - 40, 0, -0.6));
                    bullets.push(new BulletGO(_ownerID, bulletVO, aX - 3, aY - 40, 0, -0.6));

                    bullets.push(new BulletGO(_ownerID, bulletVO, aX - 45, aY - 25, -0.1, -0.6));
                    bullets.push(new BulletGO(_ownerID, bulletVO, aX + 45, aY - 25, 0.1, -0.6));
                    break;

                case 5:
                    bullets.push(new BulletGO(_ownerID, bulletVO, aX, aY - 40, 0, -0.6));

                    bullets.push(new BulletGO(_ownerID, bulletVO, aX - 47, aY - 25, -0.1, -0.6));
                    bullets.push(new BulletGO(_ownerID, bulletVO, aX - 53, aY - 25, -0.1, -0.6));

                    bullets.push(new BulletGO(_ownerID, bulletVO, aX + 47, aY - 25, 0.1, -0.6));
                    bullets.push(new BulletGO(_ownerID, bulletVO, aX + 53, aY - 25, 0.1, -0.6));
                    break;

                case 6:
                case 7:
                case 8:
                case 9:
                    bullets.push(new BulletGO(_ownerID, bulletVO, aX + 3, aY - 40, 0, -0.6));
                    bullets.push(new BulletGO(_ownerID, bulletVO, aX - 3, aY - 40, 0, -0.6));

                    bullets.push(new BulletGO(_ownerID, bulletVO, aX - 47, aY - 25, -0.1, -0.6));
                    bullets.push(new BulletGO(_ownerID, bulletVO, aX - 53, aY - 25, -0.1, -0.6));

                    bullets.push(new BulletGO(_ownerID, bulletVO, aX + 47, aY - 25, 0.1, -0.6));
                    bullets.push(new BulletGO(_ownerID, bulletVO, aX + 53, aY - 25, 0.1, -0.6));
                    break;

                case 10:
                    bullets.push(new BulletGO(_ownerID, bulletVO, aX + 9, aY - 40, 0, -0.6));
                    bullets.push(new BulletGO(_ownerID, bulletVO, aX + 3, aY - 40, 0, -0.6));
                    bullets.push(new BulletGO(_ownerID, bulletVO, aX - 3, aY - 40, 0, -0.6));
                    bullets.push(new BulletGO(_ownerID, bulletVO, aX - 9, aY - 40, 0, -0.6));

                    bullets.push(new BulletGO(_ownerID, bulletVO, aX - 47, aY - 25, -0.1, -0.6));
                    bullets.push(new BulletGO(_ownerID, bulletVO, aX - 53, aY - 25, -0.1, -0.6));

                    bullets.push(new BulletGO(_ownerID, bulletVO, aX + 47, aY - 25, 0.1, -0.6));
                    bullets.push(new BulletGO(_ownerID, bulletVO, aX + 53, aY - 25, 0.1, -0.6));
            }

            _shootSignal.dispatch(bullets);

            super.shoot(aX, aY);
        }
    }
}