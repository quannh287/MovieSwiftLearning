//
//  PageIndicator.swift
//  MovieSwiftLearning
//

import SwiftUI

// PageIndicator: chấm tròn/capsule chỉ trang hiện tại
// So sánh với RN: custom dots component
// So sánh với Flutter: DotsIndicator package / custom Row
struct PageIndicator: View {
    let currentPage: Int
    let totalPages: Int
    var activeColor: Color = Color(red: 0.9, green: 0.2, blue: 0.2)
    var inactiveColor: Color = Color.white.opacity(0.3)

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalPages, id: \.self) { i in
                Capsule()
                    .fill(i == currentPage ? activeColor : inactiveColor)
                    .frame(width: i == currentPage ? 24 : 8, height: 4)
                    .animation(.easeInOut(duration: 0.25), value: currentPage)
            }
        }
    }
}

#Preview {
    VStack(spacing: 24) {
        PageIndicator(currentPage: 0, totalPages: 3)
        PageIndicator(currentPage: 1, totalPages: 3)
        PageIndicator(currentPage: 2, totalPages: 3)
    }
    .padding()
    .background(Color.black)
}
