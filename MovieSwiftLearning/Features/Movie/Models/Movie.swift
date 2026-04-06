//
//  Movie.swift
//  MovieSwiftLearning
//

import Foundation

struct Movie: Identifiable, Codable, Hashable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double
    let releaseDate: String?
    let genreIds: [Int]

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
    }

    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }

    var backdropURL: URL? {
        guard let path = backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w780\(path)")
    }

    var formattedRating: String {
        String(format: "%.1f", voteAverage)
    }
}

// MARK: - Mock Data
extension Movie {
    static let mockData: [Movie] = [
        Movie(
            id: 1,
            title: "Dune: Part Two",
            overview: "Follow the mythic journey of Paul Atreides as he unites with Chani and the Fremen while on a path of revenge against the conspirators who destroyed his family.",
            posterPath: "/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg",
            backdropPath: "/xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg",
            voteAverage: 8.3,
            releaseDate: "2024-02-27",
            genreIds: [878, 12]
        ),
        Movie(
            id: 2,
            title: "Oppenheimer",
            overview: "The story of J. Robert Oppenheimer's role in the development of the atomic bomb during World War II.",
            posterPath: "/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg",
            backdropPath: "/fm6KqXpk3M2HVveHwCrBSSBaO0V.jpg",
            voteAverage: 8.1,
            releaseDate: "2023-07-19",
            genreIds: [18, 36]
        ),
        Movie(
            id: 3,
            title: "Poor Things",
            overview: "The incredible tale about the fantastical evolution of Bella Baxter, a young woman brought back to life by the brilliant and unorthodox scientist Dr. Godwin Baxter.",
            posterPath: "/kCGlIMHnOm8JPXNbM7BHhpfzgsD.jpg",
            backdropPath: "/bQXAqRx2Fgc46uCVWgoPz5L5Dtr.jpg",
            voteAverage: 7.9,
            releaseDate: "2023-12-07",
            genreIds: [878, 18, 35]
        ),
        Movie(
            id: 4,
            title: "The Zone of Interest",
            overview: "The commandant of Auschwitz, Rudolf Höss, and his wife Hedwig, strive to build a dream life for their family in a house and garden next to the camp.",
            posterPath: "/hUu9zyZmKuWrSVHFvJJAGKhmkHe.jpg",
            backdropPath: "/oBSFBJbPYb0GIRGGRMHKPJJFqYNt.jpg",
            voteAverage: 7.4,
            releaseDate: "2023-12-15",
            genreIds: [18, 36, 10752]
        ),
        Movie(
            id: 5,
            title: "Killers of the Flower Moon",
            overview: "When oil is discovered in 1920s Oklahoma under Osage Nation land, the Osage people are murdered one by one—until the FBI steps in to unravel the mystery.",
            posterPath: "/dB6jkAMkNPQOBL7gFQO4kPCRZHT.jpg",
            backdropPath: "/1X7vow16X7CnCoexXh4H4F2yDJv.jpg",
            voteAverage: 7.5,
            releaseDate: "2023-10-18",
            genreIds: [80, 18, 36]
        )
    ]
}
