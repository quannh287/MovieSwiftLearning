//
//  MovieRatingBadge.swift
//  MovieSwiftLearning
//

import SwiftUI

// Bài tập 1.1: Component đơn giản nhất
// So sánh với RN: <Badge value={rating} /> functional component
// SwiftUI: struct conform View, props = stored properties
struct MovieRatingBadge: View {
    let rating: Double

    private var ratingColor: Color {
        switch rating {
        case 7.5...: return .green
        case 6.0..<7.5: return .orange
        default: return .red
        }
    }

    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: "star.fill")
                .font(.system(size: 10))
            Text(String(format: "%.1f", rating))
                .font(.caption)
                .fontWeight(.semibold)
        }
        .foregroundColor(.white)
        .padding(.horizontal, 6)
        .padding(.vertical, 3)
        .background(ratingColor)
        .cornerRadius(6)
    }
}

#Preview {
    VStack(spacing: 12) {
        MovieRatingBadge(rating: 8.5)
        MovieRatingBadge(rating: 6.8)
        MovieRatingBadge(rating: 4.2)
    }
    .padding()
}
