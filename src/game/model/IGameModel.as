package game.model
{
    import game.model.gameObject.BulletGO;
    import game.model.gameObject.ObstacleGO;

    import org.osflash.signals.Signal;

    public interface IGameModel
    {
        function get playerBullets(): Vector.<BulletGO>;

        function get enemyBullets(): Vector.<BulletGO>;

        function get enemies(): Vector.<GameObject>;

        function get bonuses(): Vector.<GameObject>;

        function get obstacles(): Vector.<ObstacleGO>;


        function get numPlayers(): uint;

        function get enemySpawnedSignal(): Signal;

        function get obstacleSpawnedSignal(): Signal;

        function get bonusSpawnedSignal(): Signal;

        function get bulletSpawnedSignal(): Signal;

        function get gameObjectRemovedSignal(): Signal;

        function get gameObjectHitSignal(): Signal;

        function get aoeDamageTriggeredSignal(): Signal;

        function getPlayerModelByID(aID: uint = 0): GameObject;

        function init(): void;

        function destroy(): void;

        function get finishedLevel(): Boolean;
    }
}
