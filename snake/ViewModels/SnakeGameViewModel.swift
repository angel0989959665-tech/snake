import Foundation
import Combine

@MainActor
final class SnakeGameViewModel: ObservableObject {
    @Published private(set) var gameState: GameState = .idle
    @Published private(set) var snake: Snake = Snake(segments: BoardConfig.initialSnakeSegments)
    @Published private(set) var foodPosition: GridPoint = GridPoint(row: 4, column: 4)
    @Published private(set) var bombPosition: GridPoint?
    @Published private(set) var obstacles: Set<GridPoint> = []
    @Published private(set) var score: Int = 0
    @Published private(set) var currentDirection: Direction = BoardConfig.initialDirection
    @Published private(set) var scoreHistory: [ScoreRecord] = []
    
    var bestScore: Int {
        scoreHistory.map(\.score).max() ?? 0
    }
    
    var topFiveHistory: [ScoreRecord] {
        Array(scoreHistory.prefix(5))
    }
    
    private var pendingDirection: Direction = BoardConfig.initialDirection
    private var timer: Timer?
    
    private let scoreHistoryKey = "snake.score.history.v1"
    
    init() {
        loadScoreHistory()
        resetGameData()
    }
    
    deinit {
        timer?.invalidate()
    }
    
    func startGame() {
        stopGameLoop()
        resetGameData()
        gameState = .running
        startGameLoop()
    }
    
    func restartGame() {
        startGame()
    }
    
    func handleDirectionInput(_ newDirection: Direction) {
        guard gameState == .running else { return }
        guard newDirection != currentDirection.opposite else { return }
        pendingDirection = newDirection
    }
    
    private func startGameLoop() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: BoardConfig.tickInterval, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.tick()
            }
        }
    }
    
    private func stopGameLoop() {
        timer?.invalidate()
        timer = nil
    }
    
    private func tick() {
        guard gameState == .running else { return }
        
        if pendingDirection != currentDirection.opposite {
            currentDirection = pendingDirection
        }
        
        let newHead = snake.head.moved(currentDirection)
        
        // 撞牆
        guard isInsideBoard(newHead) else {
            endGame()
            return
        }
        
        // 撞障礙物
        if obstacles.contains(newHead) {
            endGame()
            return
        }
        
        // 撞炸彈
        if newHead == bombPosition {
            endGame()
            return
        }
        
        let willEatFood = newHead == foodPosition
        
        // 沒吃到食物時，尾巴會前進，所以撞自己判定要排除最後一格
        let bodyToCheck = willEatFood ? snake.segments : Array(snake.segments.dropLast())
        if bodyToCheck.contains(newHead) {
            endGame()
            return
        }
        
        var newSegments = [newHead] + snake.segments
        
        if !willEatFood {
            newSegments.removeLast()
        }
        
        snake = Snake(segments: newSegments)
        
        if willEatFood {
            score += BoardConfig.scorePerFood
            
            var blocked = Set(newSegments)
            blocked.formUnion(obstacles)
            if let bomb = bombPosition {
                blocked.insert(bomb)
            }
            
            if let nextFood = generateSinglePoint(excluding: blocked) {
                foodPosition = nextFood
            } else {
                // 代表版面幾乎滿了，也可視為勝利型結束
                endGame()
            }
        }
    }
    
    private func endGame() {
        guard gameState == .running else { return }
        gameState = .gameOver
        stopGameLoop()
        saveCurrentScoreIfNeeded()
    }
    
    private func resetGameData() {
        score = 0
        snake = Snake(segments: BoardConfig.initialSnakeSegments)
        currentDirection = BoardConfig.initialDirection
        pendingDirection = BoardConfig.initialDirection
        
        let snakeSet = Set(snake.segments)
        
        obstacles = generateObstaclePositions(
            excluding: snakeSet,
            count: BoardConfig.obstacleCount
        )
        
        var blocked = snakeSet
        blocked.formUnion(obstacles)
        
        bombPosition = generateSinglePoint(excluding: blocked)
        if let bomb = bombPosition {
            blocked.insert(bomb)
        }
        
        foodPosition = generateSinglePoint(excluding: blocked) ?? GridPoint(row: 0, column: 0)
        gameState = .idle
    }
    
    private func isInsideBoard(_ point: GridPoint) -> Bool {
        point.row >= 0 &&
        point.row < BoardConfig.rows &&
        point.column >= 0 &&
        point.column < BoardConfig.columns
    }
    
    private func allBoardPoints() -> [GridPoint] {
        var points: [GridPoint] = []
        
        for row in 0..<BoardConfig.rows {
            for column in 0..<BoardConfig.columns {
                points.append(GridPoint(row: row, column: column))
            }
        }
        
        return points
    }
    
    private func generateSinglePoint(excluding excluded: Set<GridPoint>) -> GridPoint? {
        allBoardPoints()
            .filter { !excluded.contains($0) }
            .randomElement()
    }
    
    private func generateObstaclePositions(excluding excluded: Set<GridPoint>, count: Int) -> Set<GridPoint> {
        let candidates = allBoardPoints()
            .filter { !excluded.contains($0) }
            .shuffled()
        
        return Set(candidates.prefix(count))
    }
    
    private func loadScoreHistory() {
        guard let data = UserDefaults.standard.data(forKey: scoreHistoryKey),
              let decoded = try? JSONDecoder().decode([ScoreRecord].self, from: data) else {
            scoreHistory = []
            return
        }
        
        scoreHistory = decoded
    }
    
    private func saveCurrentScoreIfNeeded() {
        guard score > 0 else { return }
        
        var updated = scoreHistory
        updated.append(ScoreRecord(score: score))
        
        updated.sort {
            if $0.score == $1.score {
                return $0.createdAt > $1.createdAt
            }
            return $0.score > $1.score
        }
        
        updated = Array(updated.prefix(BoardConfig.maxHistoryRecords))
        scoreHistory = updated
        
        if let data = try? JSONEncoder().encode(updated) {
            UserDefaults.standard.set(data, forKey: scoreHistoryKey)
        }
    }
}
