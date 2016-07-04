package game.model.gameObject.component.weapon
{
    import game.model.GameObject;
    import game.model.gameObject.IGameObjectFactory;
    import game.model.gameObject.component.Component;
    import game.model.gameObject.component.control.WeaponControlComponent;
    import game.model.gameObject.component.fsm.ITargetProvider;
    import game.model.gameObject.component.weapon.enums.WeaponType;

    import org.osflash.signals.Signal;

    public class WeaponComponent extends Component implements IWeaponComponent
    {

        private var _weaponModel: WeaponModel;
        private var _nextShotAfter: Number = 0;
        private var _shootSignal: Signal;
        private var _targetProvider: ITargetProvider;


        private var _isShooting: Boolean;
        private var _x: Number = 50;
        private var _y: Number = 0;

        private var _spawnPointIndex: Number = 0;
        private var _gameObjectFactory: IGameObjectFactory;

        public function WeaponComponent(aWeaponModel: WeaponModel, aGameObjectFactory: IGameObjectFactory, aX: Number = 0, aY: Number = 0)
        {
            _weaponModel = aWeaponModel;
            _gameObjectFactory = aGameObjectFactory;
            _x = aX;
            _y = aY;
        }

        public function get x(): Number
        {
            return _x;
        }

        public function get y(): Number
        {
            return _y;
        }

        public function get weaponModel(): WeaponModel
        {
            return _weaponModel;
        }


        override public function init(aGameObject: GameObject): void
        {
            super.init(aGameObject);

            var weaponControlComponent: WeaponControlComponent = WeaponControlComponent(gameObject.getComponent(WeaponControlComponent));
            if (weaponControlComponent)
            {
                _shootSignal = weaponControlComponent.shootSignal;
                _targetProvider = weaponControlComponent.targetProvider;
            }
            else
                _shootSignal = new Signal(Vector.<GameObject>);
        }

        override public function update(aDeltaTime: Number): void
        {
            if (_isShooting)
            {
                _nextShotAfter -= aDeltaTime;

                if (_nextShotAfter <= 0)
                {
                    shoot(gameObject.transform.x + _x, gameObject.transform.y + _y);
                    _nextShotAfter = _weaponModel.shootInterval;
                }
            }
        }

        public function startShoot(aNextShotAfter: Number = 0): void
        {
            _isShooting = true;
            _nextShotAfter = aNextShotAfter;
        }

        public function endShoot(): void
        {
            _isShooting = false;
        }

        public function shoot(aX: Number, aY: Number): void
        {
            var bullets: Vector.<GameObject> = new Vector.<GameObject>();
            var bullet: GameObject;
            var spawnPoint: BulletSpawnVO;

            switch (_weaponModel.weaponType)
            {
                case WeaponType.SINGLE:
                    spawnPoint = _weaponModel.spawnPoints[0];
                    bullet = _gameObjectFactory.createBulletGO(spawnPoint.bulletVO, gameObject.identity.concreteID, spawnPoint.speed, spawnPoint.angle, _targetProvider);
                    bullet.transform.x = aX + spawnPoint.x;
                    bullet.transform.y = aY + spawnPoint.y;
                    bullets.push(bullet);
                    break;

                case WeaponType.PARALEL:
                    for (var i: int = 0; i < _weaponModel.spawnPoints.length; i++)
                    {
                        spawnPoint = _weaponModel.spawnPoints[i];
                        bullet = _gameObjectFactory.createBulletGO(spawnPoint.bulletVO, gameObject.identity.concreteID, spawnPoint.speed, spawnPoint.angle, _targetProvider);
                        bullet.transform.x = aX + spawnPoint.x;
                        bullet.transform.y = aY + spawnPoint.y;
                        bullets.push(bullet);
                    }
                    break;

                case WeaponType.SEQUENTIAL:
                    _spawnPointIndex = (_spawnPointIndex + 1) % _weaponModel.spawnPoints.length;
                    spawnPoint = _weaponModel.spawnPoints[_spawnPointIndex];
                    bullet = _gameObjectFactory.createBulletGO(spawnPoint.bulletVO, gameObject.identity.concreteID, spawnPoint.speed, spawnPoint.angle, _targetProvider);
                    bullet.transform.x = aX + spawnPoint.x;
                    bullet.transform.y = aY + spawnPoint.y;
                    bullets.push(bullet);
                    break;
            }

            _shootSignal.dispatch(bullets);
        }
    }
}
