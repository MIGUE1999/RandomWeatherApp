import SwiftUI

protocol ThemeProtocol {
    var primaryTextColor: Color { get }
    var secondaryTextColor: Color { get }
    var backgroundGradient: LinearGradient { get }
    var cardBackground: Material { get }
    var cornerRadius: CGFloat { get }
    var spacingSmall: CGFloat { get }
    var spacingMedium: CGFloat { get }
    var spacingLarge: CGFloat { get }
    var temperatureFontSize: CGFloat { get }
    var cityFontSize: CGFloat { get }
    var descriptionFontSize: CGFloat { get }
    var iconMaxSize: CGSize { get }
}

struct DefaultTheme: ThemeProtocol {
    let primaryTextColor: Color = .white
    let secondaryTextColor: Color = .white.opacity(0.8)
    let backgroundGradient = LinearGradient(
        gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.7)]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    let cardBackground: Material = .ultraThinMaterial
    let cornerRadius: CGFloat = 25
    let spacingSmall: CGFloat = 5
    let spacingMedium: CGFloat = 20
    let spacingLarge: CGFloat = 30
    let temperatureFontSize: CGFloat = 60
    let cityFontSize: CGFloat = 34
    let descriptionFontSize: CGFloat = 20
    let iconMaxSize: CGSize = CGSize(width: 100, height: 100)
}

struct ThemeKey: EnvironmentKey {
    static let defaultValue: ThemeProtocol = DefaultTheme()
}

extension EnvironmentValues {
    var theme: ThemeProtocol {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}
