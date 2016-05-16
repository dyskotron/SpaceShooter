package highScores.model
{
    public interface IHighScoreService
    {
        function saveScore(aPlayerName: String, aScore: Number): void;

        function getHighScores(): void;
    }
}
