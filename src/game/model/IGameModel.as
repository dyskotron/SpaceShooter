package game.model
{
    import org.osflash.signals.Signal;

    public interface IGameModel
    {
        function get playerBullets(): Vector.<GameObject>;

        function get enemyBullets(): Vector.<GameObject>;

        function get enemies(): Vector.<GameObject>;

        function get bonuses(): Vector.<GameObject>;

        function get obstacles(): Vector.<GameObject>;

        function get numPlayers(): uint;

        function get enemySpawnedSignal(): Signal;

        function get obstacleSpawnedSignal(): Signal;

        function get bonusSpawnedSignal(): Signal;

        function get bulletSpawnedSignal(): Signal;

        function get gameObjectRemovedSignal(): Signal;

        function get gameObjectHitSignal(): Signal;

        function get aoeDamageTriggeredSignal(): Signal;

        function getPlayerGOByID(aID: uint = 0): GameObject;

        function init(): void;

        function destroy(): void;

        function get finishedLevel(): Boolean;
    }
}
