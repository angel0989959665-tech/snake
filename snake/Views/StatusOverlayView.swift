import SwiftUI

struct StatusOverlayView: View {
    let gameState: GameState
    let score: Int
    let onStart: () -> Void
    let onRestart: () -> Void
    
    @ViewBuilder
    var body: some View {
        switch gameState {
        case .running:
            EmptyView()
            
        case .idle:
            overlayCard(
                title: "準備開始",
                message: "吃🍎得分，避開障礙物與💣",
                buttonTitle: "Start",
                action: onStart
            )
            
        case .gameOver:
            overlayCard(
                title: "Game Over",
                message: "本局分數：\(score)",
                buttonTitle: "Restart",
                action: onRestart
            )
        }
    }
    
    private func overlayCard(
        title: String,
        message: String,
        buttonTitle: String,
        action: @escaping () -> Void
    ) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.black.opacity(0.5))
            
            VStack(spacing: 12) {
                Text(title)
                    .font(.title.bold())
                    .foregroundStyle(.white)
                
                Text(message)
                    .font(.body)
                    .foregroundStyle(.white.opacity(0.92))
                
                Button(buttonTitle, action: action)
                    .font(.headline)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.white)
                    .foregroundStyle(.black)
                    .clipShape(Capsule())
            }
            .padding(24)
        }
        .padding(28)
    }
}
