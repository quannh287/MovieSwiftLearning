//
//  ShimmerStyle.swift
//  MovieSwiftLearning
//

import SwiftUI

// Bài tập 1.3: Custom ViewModifier — loading skeleton
// So sánh với RN: Animated + interpolate + LinearGradient
// SwiftUI: ViewModifier + @State animation
struct ShimmerStyle: ViewModifier {
    @State private var isAnimating = false

    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    LinearGradient(
                        gradient: Gradient(colors: [
                            .clear,
                            Color.white.opacity(0.4),
                            .clear
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: geometry.size.width * 2)
                    .offset(x: isAnimating ? geometry.size.width : -geometry.size.width)
                }
                .clipped()
            )
            .onAppear {
                withAnimation(
                    .linear(duration: 1.2)
                    .repeatForever(autoreverses: false)
                ) {
                    isAnimating = true
                }
            }
    }
}

extension View {
    func shimmerStyle() -> some View {
        modifier(ShimmerStyle())
    }
}

#Preview {
    VStack(spacing: 12) {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.gray.opacity(0.3))
            .frame(width: 100, height: 150)
            .shimmerStyle()

        RoundedRectangle(cornerRadius: 4)
            .fill(Color.gray.opacity(0.3))
            .frame(width: 200, height: 16)
            .shimmerStyle()
    }
    .padding()
}
