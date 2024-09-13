import SwiftUI

struct Theme {
    static let primaryColor = Color("PrimaryColor")       // Cornflower Blue
    static let secondaryColor = Color("SecondaryColor")   // Dark Slate Gray
    static let accentColor = Color("AccentColor")         // Light Pink or your chosen accent color

    // Typography
    static let titleFont = Font.system(size: 28, weight: .bold, design: .rounded)
    static let headlineFont = Font.system(size: 20, weight: .semibold, design: .rounded)
    static let bodyFont = Font.system(size: 16, weight: .regular, design: .rounded)
}
