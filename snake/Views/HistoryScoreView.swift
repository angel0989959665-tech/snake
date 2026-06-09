import SwiftUI

struct HistoryScoreView: View {
    let records: [ScoreRecord]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("歷史排行榜")
                .font(.headline)
            
            if records.isEmpty {
                Text("目前還沒有紀錄，先來跑一局吧。")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            } else {
                VStack(spacing: 10) {
                    ForEach(Array(records.enumerated()), id: \.element.id) { index, record in
                        HStack {
                            Text("#\(index + 1)")
                                .font(.subheadline.bold())
                                .frame(width: 36, alignment: .leading)
                            
                            Text("\(record.score) 分")
                                .font(.body.bold())
                                .monospacedDigit()
                            
                            Spacer()
                            
                            Text(Self.dateFormatter.string(from: record.createdAt))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 4)
                        
                        if index < records.count - 1 {
                            Divider()
                        }
                    }
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.black.opacity(0.08), lineWidth: 1)
        )
    }
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_TW")
        formatter.dateFormat = "MM/dd HH:mm"
        return formatter
    }()
}
