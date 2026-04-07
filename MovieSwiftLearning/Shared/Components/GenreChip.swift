//
//  GenreChip.swift
//  MovieSwiftLearning
//

import SwiftUI

// MARK: - GenreChip

// GenreChip: chip button để chọn/bỏ chọn một genre
// So sánh với RN: <TouchableOpacity> với conditional style
// So sánh với Flutter: FilterChip widget
struct GenreChip: View {
    let title: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(title)
                .font(.inter(.subheadline))
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

// MARK: - GenreChipGroup

// GenreChipGroup: layout nhiều GenreChip tự wrap sang hàng mới khi hết width
// So sánh với RN: <View style={{ flexDirection: 'row', flexWrap: 'wrap' }}>
// So sánh với Flutter: Wrap widget
struct GenreChipGroup: View {
    let genres: [String]
    let selectedGenres: Set<String>
    let spacing: CGFloat
    let lineSpacing: CGFloat
    let onTap: (String) -> Void

    init(
        genres: [String],
        selectedGenres: Set<String>,
        spacing: CGFloat = 10,
        lineSpacing: CGFloat = 14,
        onTap: @escaping (String) -> Void
    ) {
        self.genres = genres
        self.selectedGenres = selectedGenres
        self.spacing = spacing
        self.lineSpacing = lineSpacing
        self.onTap = onTap
    }

    var body: some View {
        FlowLayout(items: genres, spacing: spacing, lineSpacing: lineSpacing) { genre in
            GenreChip(
                title: genre,
                isSelected: selectedGenres.contains(genre)
            ) {
                onTap(genre)
            }
        }
    }
}

// MARK: - FlowLayout

// FlowLayout: wrap items tự động sang hàng tiếp theo khi hết width
// So sánh với RN: flexWrap: 'wrap' trên <View>
// So sánh với Flutter: Wrap widget
struct FlowLayout<Item: Hashable, Content: View>: View {
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

// MARK: - Preview

#Preview("Chips") {
    HStack(spacing: 12) {
        GenreChip(title: "Action", isSelected: true) {}
        GenreChip(title: "Drama", isSelected: false) {}
    }
    .padding()
    .background(Color.black)
}

#Preview("Group") {
    GenreChipGroup(
        genres: ["Action", "Adventure", "Drama", "Comedy", "Crime", "Documentary", "Sports", "Fantasy", "Horror", "Music", "Western", "Thriller", "Sci-fi"],
        selectedGenres: ["Action", "Horror"]
    ) { _ in }
    .padding(24)
    .frame(height: 300)
    .background(Color.black)
}
