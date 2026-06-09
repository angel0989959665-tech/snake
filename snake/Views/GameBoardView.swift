import SwiftUI

struct GameBoardView: View {
    let rows: Int
    let columns: Int
    let snake: Snake
    let foodPosition: GridPoint
    let bombPosition: GridPoint?
    let obstacles: Set<GridPoint>
    let currentDirection: Direction
    
    var body: some View {
        let snakeBodySet = Set(snake.segments.dropFirst())
        
        VStack(spacing: 2) {
            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: 2) {
                    ForEach(0..<columns, id: \.self) { column in
                        cellView(
                            at: GridPoint(row: row, column: column),
                            snakeBodySet: snakeBodySet
                        )
                    }
                }
            }
        }
        .padding(6)
        .background(Color.black.opacity(0.35))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.black.opacity(0.45), lineWidth: 2)
        )
    }
    
    @ViewBuilder
    private func cellView(at point: GridPoint, snakeBodySet: Set<GridPoint>) -> some View {
        let isHead = point == snake.head
        let isBody = snakeBodySet.contains(point)
        let isFood = point == foodPosition
        let isBomb = point == bombPosition
        let isObstacle = obstacles.contains(point)
        
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(cellColor(
                    isHead: isHead,
                    isBody: isBody,
                    isFood: isFood,
                    isBomb: isBomb,
                    isObstacle: isObstacle
                ))
            
            if isHead {
                Image(systemName: "arrowtriangle.up.fill")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(.white)
                    .rotationEffect(.degrees(angleForDirection(currentDirection)))
            } else if isFood {
                Text("🍎")
                    .font(.system(size: 13))
            } else if isBomb {
                Text("💣")
                    .font(.system(size: 13))
            } else if isObstacle {
                Text("✕")
                    .font(.system(size: 13, weight: .black))
                    .foregroundStyle(.white)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    private func cellColor(
        isHead: Bool,
        isBody: Bool,
        isFood: Bool,
        isBomb: Bool,
        isObstacle: Bool
    ) -> Color {
        if isHead {
            return .green
        }
        
        if isBody {
            return Color.green.opacity(0.78)
        }
        
        if isFood {
            return Color.red.opacity(0.88)
        }
        
        if isBomb {
            return Color.orange.opacity(0.95)
        }
        
        if isObstacle {
            return Color.gray.opacity(0.85)
        }
        
        return Color.gray.opacity(0.14)
    }
    
    private func angleForDirection(_ direction: Direction) -> Double {
        switch direction {
        case .up:
            return 0
        case .right:
            return 90
        case .down:
            return 180
        case .left:
            return 270
        }
    }
}

