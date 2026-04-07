//
//  Font+Inter.swift
//  MovieSwiftLearning
//

import SwiftUI

// Font+Inter: extension ánh xạ Inter font family vào các semantic text styles
// So sánh với RN: StyleSheet.create({ heading: { fontFamily: 'Inter-Bold', fontSize: 28 } })
// So sánh với Flutter: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold)
//
// Cách dùng:
//   .font(.inter(.largeTitle))    → Inter Bold 34
//   .font(.inter(.title))         → Inter SemiBold 28
//   .font(.inter(.title2))        → Inter SemiBold 22
//   .font(.inter(.title3))        → Inter SemiBold 20
//   .font(.inter(.headline))      → Inter SemiBold 17
//   .font(.inter(.body))          → Inter Regular 17
//   .font(.inter(.callout))       → Inter Regular 16
//   .font(.inter(.subheadline))   → Inter Medium 15
//   .font(.inter(.footnote))      → Inter Regular 13
//   .font(.inter(.caption))       → Inter Regular 12
//   .font(.inter(.caption2))      → Inter Regular 11
//
// Custom size:
//   .font(.inter(size: 24, weight: .bold))

extension Font {

    // MARK: - Semantic styles (khớp với Apple text styles)

    static func inter(_ style: Font.TextStyle) -> Font {
        switch style {
        case .largeTitle:   return .inter(size: 34, weight: .bold)
        case .title:        return .inter(size: 28, weight: .semiBold)
        case .title2:       return .inter(size: 22, weight: .semiBold)
        case .title3:       return .inter(size: 20, weight: .semiBold)
        case .headline:     return .inter(size: 17, weight: .semiBold)
        case .body:         return .inter(size: 17, weight: .regular)
        case .callout:      return .inter(size: 16, weight: .regular)
        case .subheadline:  return .inter(size: 15, weight: .medium)
        case .footnote:     return .inter(size: 13, weight: .regular)
        case .caption:      return .inter(size: 12, weight: .regular)
        case .caption2:     return .inter(size: 11, weight: .regular)
        @unknown default:   return .inter(size: 17, weight: .regular)
        }
    }

    // MARK: - Custom size + weight

    static func inter(size: CGFloat, weight: InterWeight = .regular) -> Font {
        .custom(weight.fontName, size: size)
    }

    // MARK: - Inter weight enum (chỉ 4 weights được dùng trong app)

    enum InterWeight {
        case regular
        case medium
        case semiBold
        case bold

        var fontName: String {
            switch self {
            case .regular:  return "Inter-Regular"
            case .medium:   return "Inter-Medium"
            case .semiBold: return "Inter-SemiBold"
            case .bold:     return "Inter-Bold"
            }
        }
    }
}

// MARK: - Preview

#Preview {
    VStack(alignment: .leading, spacing: 12) {
        Text("Large Title — Inter Bold").font(.inter(.largeTitle))
        Text("Title — Inter SemiBold").font(.inter(.title))
        Text("Title 2 — Inter SemiBold").font(.inter(.title2))
        Text("Title 3 — Inter SemiBold").font(.inter(.title3))
        Text("Headline — Inter SemiBold").font(.inter(.headline))
        Text("Body — Inter Regular").font(.inter(.body))
        Text("Callout — Inter Regular").font(.inter(.callout))
        Text("Subheadline — Inter Medium").font(.inter(.subheadline))
        Text("Footnote — Inter Regular").font(.inter(.footnote))
        Text("Caption — Inter Regular").font(.inter(.caption))
        Text("Caption 2 — Inter Regular").font(.inter(.caption2))
        Divider()
        Text("Custom 24 Bold").font(.inter(size: 24, weight: .bold))
        Text("Custom 14 Medium").font(.inter(size: 14, weight: .medium))
    }
    .padding(24)
    .frame(maxWidth: .infinity, alignment: .leading)
}
