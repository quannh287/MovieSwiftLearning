//
//  MovieDetailView.swift
//  MovieSwiftLearning
//

import SwiftUI

struct MovieDetailView: View {
    // @StateObject = view sở hữu ViewModel (tạo và quản lý lifetime)
    // So sánh với RN: const vm = useRef(new ViewModel()).current
    @StateObject private var viewModel: MovieDetailViewModel

    init(movie: Movie) {
        // _viewModel vì @StateObject cần init đặc biệt
        _viewModel = StateObject(wrappedValue: MovieDetailViewModel(movie: movie))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Backdrop image
                MoviePosterImage(
                    url: viewModel.movie.backdropURL ?? viewModel.movie.posterURL,
                    size: .big
                )
                .frame(maxWidth: .infinity)
                .frame(height: 220)
                .clipped()

                VStack(alignment: .leading, spacing: 16) {
                    // Title + Rating
                    HStack(alignment: .top) {
                        Text(viewModel.movie.title)
                            .font(.inter(.title2))
                            .frame(maxWidth: .infinity, alignment: .leading)

                        MovieRatingBadge(rating: viewModel.movie.voteAverage)
                    }

                    // Release date
                    if let date = viewModel.movie.releaseDate {
                        Text(date)
                            .font(.inter(.caption))
                            .foregroundColor(.secondary)
                    }

                    // Overview
                    Text(viewModel.movie.overview)
                        .font(.inter(.body))
                        .foregroundColor(.primary)
                        .lineSpacing(4)
                }
                .padding(16)
            }
        }
        .navigationTitle(viewModel.movie.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        MovieDetailView(movie: Movie.mockData[0])
    }
}
