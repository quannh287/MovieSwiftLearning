//
//  MoviesListView.swift
//  MovieSwiftLearning
//

import SwiftUI

struct MoviesListView: View {
    // @StateObject: view tạo và sở hữu ViewModel
    // So sánh với RN: const [movies, setMovies] = useState([]) + useEffect fetch
    // SwiftUI: ViewModel tách logic ra, View chỉ render
    @StateObject private var viewModel = MoviesListViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    // Loading skeleton
                    List(0..<5, id: \.self) { _ in
                        loadingRow
                    }
                } else {
                    List(viewModel.movies) { movie in
                        // NavigationLink = navigation.navigate('Detail', { movie })
                        // SwiftUI: declarative — link tự biết destination
                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                            MovieRowView(movie: movie)
                        }
                    }
                }
            }
            .navigationTitle("Movies")
        }
    }

    // Loading skeleton row
    private var loadingRow: some View {
        HStack(alignment: .top, spacing: 12) {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 53, height: 80)
                .shimmerStyle()

            VStack(alignment: .leading, spacing: 8) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 16)
                    .shimmerStyle()

                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 12)
                    .shimmerStyle()

                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 120, height: 12)
                    .shimmerStyle()
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    MoviesListView()
}
