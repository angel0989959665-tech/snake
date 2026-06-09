import SwiftUI

struct SnakeGameView: View {
    @StateObject private var viewModel = SnakeGameViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                Text("Snake")
                    .font(.largeTitle.bold())
                
                ScoreView(
                    score: viewModel.score,
                    bestScore: viewModel.bestScore
                )
                
                ZStack {
                    GameBoardView(
                        rows: BoardConfig.rows,
                        columns: BoardConfig.columns,
                        snake: viewModel.snake,
                        foodPosition: viewModel.foodPosition,
                        bombPosition: viewModel.bombPosition,
                        obstacles: viewModel.obstacles,
                        currentDirection: viewModel.currentDirection
                    )
                    
                    StatusOverlayView(
                        gameState: viewModel.gameState,
                        score: viewModel.score,
                        onStart: viewModel.startGame,
                        onRestart: viewModel.restartGame
                    )
                }
                .aspectRatio(
                    CGFloat(BoardConfig.columns) / CGFloat(BoardConfig.rows),
                    contentMode: .fit
                )
                .frame(maxWidth: 420)
                
                ControlPadView(
                    isEnabled: viewModel.gameState == .running,
                    onDirectionTap: viewModel.handleDirectionInput
                )
                
                HistoryScoreView(records: viewModel.topFiveHistory)
            }
            .padding()
        }
        .background(
            Color(red: 0.96, green: 0.97, blue: 0.98)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    SnakeGameView()
}

