import Foundation

enum Direction {
    case up
    case down
    case left
    case right
    
    var opposite: Direction {
        switch self {
        case .up:
            return .down
        case .down:
            return .up
        case .left:
            return .right
        case .right:
            return .left
        }
    }
    
    var rowOffset: Int {
        switch self {
        case .up:
            return -1
        case .down:
            return 1
        case .left, .right:
            return 0
        }
    }
    
    var columnOffset: Int {
        switch self {
        case .left:
            return -1
        case .right:
            return 1
        case .up, .down:
            return 0
        }
    }
}
