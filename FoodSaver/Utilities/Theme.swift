import SwiftUI

struct Theme {
    // Palette (light/dark aware)
    private static func dynamic(_ light: Color, _ dark: Color) -> Color {
        Color { scheme in scheme == .dark ? dark : light }
    }

    // Brand accents
    static let primaryColor = dynamic(
        Color(red: 0.9098, green: 0.4549, blue: 0.1686), // Carrot
        Color(red: 0.9411, green: 0.5450, blue: 0.2705)  // Warm carrot
    )
    static let primaryColorHover = dynamic(
        Color(red: 0.8235, green: 0.3843, blue: 0.1215), // Roasted carrot
        Color(red: 0.8784, green: 0.4705, blue: 0.2078)
    )
    static let secondaryColor = dynamic(
        Color(red: 0.3686, green: 0.4862, blue: 0.4196), // Sage
        Color(red: 0.4980, green: 0.6353, blue: 0.5569)  // Warm sage
    )
    static let accentColor = dynamic(
        Color(red: 0.6588, green: 0.8196, blue: 0.4784), // Young leaf
        Color(red: 0.6275, green: 0.7529, blue: 0.4431)  // Soft leaf
    )

    // Surfaces & neutrals
    static let background = dynamic(
        Color(red: 0.976, green: 0.965, blue: 0.945),    // Warm off-white
        Color(red: 0.094, green: 0.075, blue: 0.063)     // Soil
    )
    static let surface = dynamic(
        Color(red: 1.000, green: 1.000, blue: 1.000),    // Card
        Color(red: 0.125, green: 0.102, blue: 0.086)     // Dark card
    )
    static let surfaceAlt = dynamic(
        Color(red: 0.949, green: 0.929, blue: 0.898),    // Alt surface
        Color(red: 0.165, green: 0.133, blue: 0.114)     // Alt dark surface
    )
    static let border = dynamic(
        Color(red: 0.886, green: 0.847, blue: 0.800),
        Color(red: 0.251, green: 0.211, blue: 0.188)
    )
    static let textPrimary = dynamic(
        Color(red: 0.122, green: 0.106, blue: 0.094),
        Color(red: 0.969, green: 0.949, blue: 0.925)
    )
    static let textSecondary = dynamic(
        Color(red: 0.294, green: 0.262, blue: 0.239),
        Color(red: 0.851, green: 0.816, blue: 0.780)
    )
    static let textTertiary = dynamic(
        Color(red: 0.431, green: 0.392, blue: 0.360),
        Color(red: 0.706, green: 0.651, blue: 0.607)
    )

    // Status colors
    static func statusBackground(for status: FoodStatus) -> Color {
        switch status {
        case .fresh:
            return dynamic(
                Color(red: 0.9137, green: 0.9607, blue: 0.9020), // #E9F5E6
                Color(red: 0.1176, green: 0.1686, blue: 0.1294)  // #1E2B21
            )
        case .expiring:
            return dynamic(
                Color(red: 1.0000, green: 0.9529, blue: 0.8784), // #FFF3E0
                Color(red: 0.1725, green: 0.1411, blue: 0.0863)  // #2C2416
            )
        case .expired:
            return dynamic(
                Color(red: 0.9843, green: 0.9137, blue: 0.9373), // #FBE9EF
                Color(red: 0.1922, green: 0.0941, blue: 0.1333)  // #311822
            )
        }
    }

    static func statusText(for status: FoodStatus) -> Color {
        switch status {
        case .fresh:
            return dynamic(
                Color(red: 0.2000, green: 0.4196, blue: 0.1843), // #336B2F
                Color(red: 0.6588, green: 0.8196, blue: 0.4784)
            )
        case .expiring:
            return dynamic(
                Color(red: 0.5411, green: 0.3568, blue: 0.1176), // #8A5B1E
                Color(red: 0.9215, green: 0.7411, blue: 0.4823)
            )
        case .expired:
            return dynamic(
                Color(red: 0.4823, green: 0.1176, blue: 0.2274), // #7B1E3A
                Color(red: 0.9333, green: 0.6941, blue: 0.7608)
            )
        }
    }

    static let cardShadow = Color.black.opacity(0.08)
    static let cardShadowDark = Color.black.opacity(0.4)

    // Typography
    static let displayFont = Font.system(size: 32, weight: .semibold, design: .rounded)
    static let titleFont = Font.system(size: 28, weight: .semibold, design: .rounded)
    static let headlineFont = Font.system(size: 20, weight: .semibold, design: .rounded)
    static let bodyFont = Font.system(size: 17, weight: .regular, design: .rounded)
    static let captionFont = Font.system(size: 13, weight: .medium, design: .rounded)

    // Spacing
    enum Spacing {
        static let xs: CGFloat = 8
        static let sm: CGFloat = 12
        static let md: CGFloat = 16
        static let lg: CGFloat = 20
        static let xl: CGFloat = 24
    }
}
