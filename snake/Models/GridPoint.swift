import Foundation

struct GridPoint: Hashable {
    let row: Int
    let column: Int
    
    func moved(_ direction: Direction) -> GridPoint {
        GridPoint(
            row: row + direction.rowOffset,
            column: column + direction.columnOffset
        )
    }
}
