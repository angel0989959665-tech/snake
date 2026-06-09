import Foundation

struct BoardConfig {
    static let rows: Int = 14
    static let columns: Int = 14
    
    // 原本 0.22，改成 0.35 會明顯慢很多
    static let tickInterval: TimeInterval = 0.35
    
    static let scorePerFood: Int = 1
    
    // 原本 8，改成 4
    static let obstacleCount: Int = 4
    static let maxHistoryRecords: Int = 10
    
    static let initialDirection: Direction = .right
    
    static let initialSnakeSegments: [GridPoint] = [
        GridPoint(row: 7, column: 5),
        GridPoint(row: 7, column: 4),
        GridPoint(row: 7, column: 3)
    ]
}

