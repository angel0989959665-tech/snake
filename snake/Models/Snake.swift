import Foundation

struct Snake {
    var segments: [GridPoint]
    
    var head: GridPoint {
        segments[0]
    }
    
    func contains(_ point: GridPoint) -> Bool {
        segments.contains(point)
    }
}
