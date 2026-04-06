//
//  Color+Theme.swift
//  MovieSwiftLearning
//

import SwiftUI

extension Color {

    // MARK: - Brand Colors

    /// Primary brand color — used for accents, CTAs, and key interactive elements.
    /// React Native equivalent: `Colors.primary`
    static let appPrimary = Color(hex: 0xEB2F3D)

    /// Secondary brand color — dark charcoal for backgrounds and cards.
    static let appSecondary = Color(hex: 0x41403E)

    /// Tertiary brand color — near-black for deep backgrounds.
    static let appTertiary = Color(hex: 0x121011)

    /// Faded text color — used for secondary/muted labels.
    /// Flutter equivalent: `Colors.grey[400]`
    static let appTextFaded = Color(hex: 0x939392)
}

// MARK: - Hex Initializer

extension Color {

    /// Create a Color from a hex integer (e.g. `Color(hex: 0xEB2F3D)`).
    init(hex: UInt, opacity: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: opacity
        )
    }
}
