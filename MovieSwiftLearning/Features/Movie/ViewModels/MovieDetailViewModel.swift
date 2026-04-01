//
//  MovieDetailViewModel.swift
//  MovieSwiftLearning
//

import Foundation
import Combine

final class MovieDetailViewModel: ObservableObject {
    @Published var movie: Movie

    // Tier 1: nhận movie từ list, không cần fetch API
    // Tier 2 sẽ refactor để fetch detail thật từ TMDB
    init(movie: Movie) {
        self.movie = movie
    }
}
