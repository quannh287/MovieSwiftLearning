//
//  MovieRowView.swift
//  MovieSwiftLearning
//

import SwiftUI

// So sánh với RN: functional component nhận props
// SwiftUI: struct conform View, props = stored properties (không cần PropTypes)
struct MovieRowView: View {
    let movie: Movie

    var body: some View {
        // HStack = flexDirection: 'row' trong RN
        HStack(alignment: .top, spacing: 12) {
            MoviePosterImage(url: movie.posterURL, size: .small)

            // VStack = flexDirection: 'column' trong RN
            VStack(alignment: .leading, spacing: 6) {
                Text(movie.title)
                    .font(.headline)
                    .lineLimit(2)

                Text(movie.overview)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(3)

                // Spacer = flex: 1 trong RN (đẩy badge xuống dưới)
                Spacer(minLength: 0)

                MovieRatingBadge(rating: movie.voteAverage)
            }
            // .frame(maxWidth: .infinity) = flex: 1 trong RN
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    List {
        MovieRowView(movie: Movie.mockData[0])
        MovieRowView(movie: Movie.mockData[1])
    }
}
