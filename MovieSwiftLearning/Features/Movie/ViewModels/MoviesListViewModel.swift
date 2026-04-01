//
//  MoviesListViewModel.swift
//  MovieSwiftLearning
//

import Foundation
import Combine

// So sánh với RN: custom hook useMoviesList()
// Flutter: ChangeNotifier class
// SwiftUI: ObservableObject class với @Published properties
final class MoviesListViewModel: ObservableObject {
    // @Published = notifyListeners() trong Flutter / setState trigger trong RN
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false

    init() {
        loadMockData()
    }

    private func loadMockData() {
        isLoading = true
        // Simulate network delay để test shimmer loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.movies = Movie.mockData
            self.isLoading = false
        }
    }
}
