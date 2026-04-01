//
//  PosterStyle.swift
//  MovieSwiftLearning
//

import SwiftUI

// MARK: - Size Enum
// So sánh với RN: style={{ width: 100, height: 150 }}
// SwiftUI: đưa sizing vào enum, view chỉ truyền case
enum PosterSize {
    case small   // 53×80pt   — thumbnails, list rows nhỏ
    case medium  // 100×150pt — standard cards
    case big     // 250×375pt — hero, detail screen

    var width: CGFloat {
        switch self {
        case .small:  return 53
        case .medium: return 100
        case .big:    return 250
        }
    }

    var height: CGFloat {
        switch self {
        case .small:  return 80
        case .medium: return 150
        case .big:    return 375
        }
    }

    var cornerRadius: CGFloat {
        switch self {
        case .small:  return 4
        case .medium: return 8
        case .big:    return 12
        }
    }
}

// MARK: - ViewModifier
// So sánh với RN: HOC wrapping style
// SwiftUI: ViewModifier là cách chuẩn tái sử dụng style
struct PosterStyle: ViewModifier {
    let size: PosterSize

    func body(content: Content) -> some View {
        content
            .frame(width: size.width, height: size.height)
            .cornerRadius(size.cornerRadius)
            .clipped()
    }
}

// MARK: - View Extension (convenience)
// So sánh với RN: custom hook wrapping style logic
// SwiftUI: extension trên View để dùng như modifier chain
extension View {
    func posterStyle(size: PosterSize) -> some View {
        modifier(PosterStyle(size: size))
    }
}
