import SwiftUI

struct ControlPadView: View {
    let isEnabled: Bool
    let onDirectionTap: (Direction) -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            DirectionButton(
                systemName: "arrow.up",
                isEnabled: isEnabled
            ) {
                onDirectionTap(.up)
            }
            
            HStack(spacing: 56) {
                DirectionButton(
                    systemName: "arrow.left",
                    isEnabled: isEnabled
                ) {
                    onDirectionTap(.left)
                }
                
                DirectionButton(
                    systemName: "arrow.right",
                    isEnabled: isEnabled
                ) {
                    onDirectionTap(.right)
                }
            }
            
            DirectionButton(
                systemName: "arrow.down",
                isEnabled: isEnabled
            ) {
                onDirectionTap(.down)
            }
        }
        .opacity(isEnabled ? 1.0 : 0.6)
    }
}

private struct DirectionButton: View {
    let systemName: String
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.title2.bold())
                .foregroundStyle(.white)
                .frame(width: 64, height: 64)
                .background(
                    Circle()
                        .fill(isEnabled ? Color.blue : Color.gray)
                )
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
    }
}
