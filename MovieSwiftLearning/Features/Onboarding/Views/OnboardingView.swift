//
//  OnboardingView.swift
//  MovieSwiftLearning
//
//  Created by Nguyễn Hồng Quân on 6/4/26.
//

import SwiftUI

// MARK: - Onboarding Root
struct OnboardingView: View {
    @EnvironmentObject private var router: MovieSwiftRouter

    // ViewModel owned bởi OnboardingView — giữ selectedGenres xuyên suốt flow
    // So sánh với RN: const vm = useRef(new OnboardingViewModel()).current
    @StateObject private var viewModel = OnboardingViewModel()

    @State private var currentPage: Int? = 0

    private let titles = [
        "Tell us about your\nfavorite movie genres",
        "Select the genres you\nlike to watch",
    ]

    var body: some View {
        ZStack(alignment: .top) {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                // CONTENT AREA — chỉ phần này swipe/transition
                // iOS 18: .page(indexDisplayMode:) bị unavailable, dùng ScrollView paging thay thế
                GeometryReader { geo in
                    ScrollView(.horizontal) {
                        HStack(spacing: 0) {
                            OnboardingPosterContent(viewModel: viewModel)
                                .frame(width: geo.size.width, height: geo.size.height)
                                .id(0)
                            OnboardingGenreContent(viewModel: viewModel)
                                .frame(width: geo.size.width, height: geo.size.height)
                                .id(1)
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.paging)
                    .scrollIndicators(.hidden)
                    .scrollPosition(id: $currentPage)
                }
                .frame(maxHeight: .infinity)

                // BOTTOM SECTION — cố định, ngoài ScrollView
                bottomSection
            }

            skipButton
        }
    }

    // MARK: - Fixed bottom section

    private var bottomSection: some View {
        VStack(spacing: 28) {
            Text(titles[currentPage ?? 0])
                .font(.inter(.title3))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .padding(.horizontal, 32)
                .id(currentPage)
                .transition(.opacity)
                .animation(.easeInOut(duration: 0.2), value: currentPage)

            AppButton(title: "Next", action: handleNext)

            PageIndicator(currentPage: currentPage ?? 0, totalPages: 2)
                .padding(.bottom, 36)
        }
    }

    // MARK: - Skip button

    private var skipButton: some View {
        HStack {
            Spacer()
            Button("Skip") {
                router.leaveOnboarding()
            }
            .foregroundColor(.white)
            .font(.inter(.body))
            .padding(.trailing, 24)
            .padding(.top, 8)
        }
    }

    // MARK: - Actions

    private func handleNext() {
        if (currentPage ?? 0) < 1 {
            withAnimation(.easeInOut(duration: 0.3)) {
                currentPage = (currentPage ?? 0) + 1
            }
        } else {
            // Step cuối: save genres rồi kiểm tra login để quyết định route
            viewModel.saveGenres()
            router.leaveOnboarding()
        }
    }
}

// MARK: - Content Step 1: Staggered Poster Grid

private struct OnboardingPosterContent: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: 12) {
            Spacer(minLength: 0)
            PosterRow(paths: viewModel.posterRow1, offset: 0)
            PosterRow(paths: viewModel.posterRow2, offset: -44)
            Spacer(minLength: 0)
        }
        .clipped()
    }
}

// MARK: - Content Step 2: Genre Picker

private struct OnboardingGenreContent: View {
    // ObservedObject: nhận viewModel từ parent (OnboardingView sở hữu)
    // So sánh với RN: props drilling / useContext
    // So sánh với Flutter: widget nhận ChangeNotifier qua constructor
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack {
            GenreChipGroup(
                genres: viewModel.genres,
                selectedGenres: viewModel.selectedGenres,
                onTap: viewModel.toggleGenre
            )
            .padding(.horizontal, 24)
            // padding top để tránh Skip button overlay
            .padding(.top, 60)
            Spacer(minLength: 0)
        }
    }
}

// MARK: - Preview

#Preview("Dark") {
    OnboardingView()
        .environmentObject(MovieSwiftRouter())
        .preferredColorScheme(.dark)
}

#Preview("Light") {
    OnboardingView()
        .environmentObject(MovieSwiftRouter())
        .preferredColorScheme(.light)
}
