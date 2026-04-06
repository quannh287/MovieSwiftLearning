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
                            OnboardingGenreContent(viewModel: viewModel)
                                .frame(width: geo.size.width, height: geo.size.height)
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.paging)
                    .scrollIndicators(.hidden)
                    .scrollPosition(id: $currentPage)
                }
                .frame(maxHeight: .infinity)

                // BOTTOM SECTION — cố định, ngoài TabView
                bottomSection
            }

            // Skip overlay — luôn nằm trên cùng
            skipButton
        }
    }

    // MARK: - Fixed bottom section

    private var bottomSection: some View {
        VStack(spacing: 28) {
            Text(titles[currentPage ?? 0])
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .padding(.horizontal, 32)
                .id(currentPage)
                .transition(.opacity)
                .animation(.easeInOut(duration: 0.2), value: currentPage)

            Button(action: handleNext) {
                Text("Next")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(Color(red: 0.9, green: 0.2, blue: 0.2))
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 24)

            OnboardingPageIndicator(currentPage: currentPage ?? 0, totalPages: 2)
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
            .font(.body)
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
    // ObservedObject: nhận viewModel từ parent
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: 12) {
            Spacer(minLength: 0)
            posterRow(paths: viewModel.posterRow1, offset: 0)
            posterRow(paths: viewModel.posterRow2, offset: -44)
            Spacer(minLength: 0)
        }
        .clipped()
    }

    private func posterRow(paths: [String], offset: CGFloat) -> some View {
        HStack(spacing: 12) {
            ForEach(paths, id: \.self) { path in
                PosterCell(urlString: "https://image.tmdb.org/t/p/w500\(path)")
            }
        }
        .offset(x: offset)
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
            FlowLayout(items: viewModel.genres, spacing: 10, lineSpacing: 14) { genre in
                GenreChip(
                    title: genre,
                    isSelected: viewModel.selectedGenres.contains(genre)
                ) {
                    viewModel.toggleGenre(genre)
                }
            }
            .padding(.horizontal, 24)
            // padding top để tránh Skip button overlay
            .padding(.top, 60)
            Spacer(minLength: 0)
        }
    }
}

// MARK: - Poster Cell

private struct PosterCell: View {
    let urlString: String

    var body: some View {
        AsyncImage(url: URL(string: urlString)) { phase in
            switch phase {
            case .success(let image):
                image.resizable().scaledToFill()
            case .failure:
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.1))
            default:
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.06))
                    .overlay(ProgressView().tint(.white))
            }
        }
        .frame(width: 88, height: 130)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Genre Chip

private struct GenreChip: View {
    let title: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding(.horizontal, 18)
                .padding(.vertical, 11)
                .background(
                    isSelected ? Color(red: 0.9, green: 0.2, blue: 0.2) : Color.clear
                )
                .overlay(
                    Capsule()
                        .stroke(Color.white.opacity(isSelected ? 0 : 0.45), lineWidth: 1)
                )
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Flow Layout

// Wrap chips tự động sang hàng tiếp theo khi hết width
private struct FlowLayout<Item: Hashable, Content: View>: View {
    let items: [Item]
    let spacing: CGFloat
    let lineSpacing: CGFloat
    @ViewBuilder let content: (Item) -> Content

    var body: some View {
        GeometryReader { geo in
            let rows = buildRows(availableWidth: geo.size.width)
            VStack(alignment: .leading, spacing: lineSpacing) {
                ForEach(rows.indices, id: \.self) { i in
                    HStack(spacing: spacing) {
                        ForEach(rows[i], id: \.self) { item in
                            content(item)
                        }
                        Spacer(minLength: 0)
                    }
                }
            }
        }
    }

    private func buildRows(availableWidth: CGFloat) -> [[Item]] {
        var rows: [[Item]] = [[]]
        var currentWidth: CGFloat = 0
        for item in items {
            let w = CGFloat(String(describing: item).count) * 9 + 36
            if currentWidth + w + spacing > availableWidth, !rows[rows.count - 1].isEmpty {
                rows.append([item])
                currentWidth = w + spacing
            } else {
                rows[rows.count - 1].append(item)
                currentWidth += w + spacing
            }
        }
        return rows
    }
}

// MARK: - Page Indicator

private struct OnboardingPageIndicator: View {
    let currentPage: Int
    let totalPages: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalPages, id: \.self) { i in
                Capsule()
                    .fill(
                        i == currentPage
                            ? Color(red: 0.9, green: 0.2, blue: 0.2)
                            : Color.white.opacity(0.3)
                    )
                    .frame(width: i == currentPage ? 24 : 8, height: 4)
                    .animation(.easeInOut(duration: 0.25), value: currentPage)
            }
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
