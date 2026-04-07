//
//  MoviePosterImage.swift
//  MovieSwiftLearning
//

import SwiftUI

// So sánh với RN: <FastImage source={{ uri }} />
// SwiftUI iOS 15+: AsyncImage built-in, không cần ObservableObject cho image loading cơ bản
struct MoviePosterImage: View {
    let url: URL?
    let size: PosterSize

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                // Loading state — dùng ShimmerStyle
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .shimmerStyle()
                    .posterStyle(size: size)

            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .posterStyle(size: size)

            case .failure:
                // Error state
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                    Image(systemName: "film")
                        .foregroundColor(.gray)
                        .font(.largeTitle)
                }
                .posterStyle(size: size)

            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    HStack(spacing: 12) {
        MoviePosterImage(
            url: URL(string: "https://image.tmdb.org/t/p/w500/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg"),
            size: .big
        )
        MoviePosterImage(
            url: URL(string: "https://image.tmdb.org/t/p/w500/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg"),
            size: .medium
        )
        MoviePosterImage(url: nil, size: .small)
    }
    .padding()
}
