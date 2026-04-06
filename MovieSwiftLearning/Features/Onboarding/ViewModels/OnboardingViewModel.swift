//
//  OnboardingViewModel.swift
//  MovieSwiftLearning
//

import Foundation
import Combine

// OnboardingViewModel: giữ state cho toàn bộ onboarding flow
// So sánh với RN: useReducer / Zustand store cho onboarding
// So sánh với Flutter: ChangeNotifier / Cubit
final class OnboardingViewModel: ObservableObject {

    // MARK: - Poster data

    // @Published để View re-render khi poster paths thay đổi (VD: load từ API)
    @Published var posterRow1: [String] = [
        "/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg",
        "/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg",
        "/kCGlIMHnOm8JPXNbM7BHhpfzgsD.jpg",
        "/hUu9zyZmKuWrSVHFvJJAGKhmkHe.jpg",
    ]

    @Published var posterRow2: [String] = [
        "/dB6jkAMkNPQOBL7gFQO4kPCRZHT.jpg",
        "/9cqNxx0GxF0bAY5K0GwY5jcaApa.jpg",
        "/gPbM0MK8CP8A174rmUwGsADNYKD.jpg",
        "/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg",
    ]

    // MARK: - Genre data

    // Danh sách tất cả genres để user chọn
    @Published var genres: [String] = [
        "Action", "Adventure", "Drama", "Comedy",
        "Crime", "Documentary", "Sports", "Fantasy",
        "Horror", "Music", "Western", "Thriller", "Sci-fi",
    ]

    // selectedGenres: Set để O(1) lookup khi toggle
    // @Published → View tự re-render khi thay đổi
    @Published var selectedGenres: Set<String> = []

    // MARK: - Actions

    func toggleGenre(_ genre: String) {
        if selectedGenres.contains(genre) {
            selectedGenres.remove(genre)
        } else {
            selectedGenres.insert(genre)
        }
    }

    // saveGenres: persist lựa chọn của user
    // Hiện dùng UserDefaults — sau này có thể thay bằng API call
    func saveGenres() {
        let sorted = selectedGenres.sorted()
        UserDefaults.standard.set(sorted, forKey: "onboarding_selected_genres")
    }

    // Lấy genres đã lưu (dùng ở màn hình khác nếu cần)
    static func savedGenres() -> [String] {
        UserDefaults.standard.stringArray(forKey: "onboarding_selected_genres") ?? []
    }
}
