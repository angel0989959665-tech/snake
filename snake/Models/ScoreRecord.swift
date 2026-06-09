import Foundation

struct ScoreRecord: Identifiable, Codable {
    let id: UUID
    let score: Int
    let createdAt: Date
    
    init(id: UUID = UUID(), score: Int, createdAt: Date = Date()) {
        self.id = id
        self.score = score
        self.createdAt = createdAt
    }
}
