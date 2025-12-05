import SwiftUI

protocol AppSpacingTokens {
    var spacing4: CGFloat { get }
    var spacing5: CGFloat { get }
    var spacing8: CGFloat { get }
    var spacing10: CGFloat { get }
    var spacing20: CGFloat { get }
    var spacing25: CGFloat { get }
    var spacing30: CGFloat { get }
    var spacing40: CGFloat { get }
}

protocol AppFontTokens {
    var fontSizeSmall: CGFloat { get }
    var fontSizeMedium: CGFloat { get }
    var fontSizeLarge: CGFloat { get }
    var fontSizeXLarge: CGFloat { get }
    var fontSizeXXLarge: CGFloat { get }
}

protocol AppColorTokens {
    var colorPrimary: Color { get }
    var colorSecondary: Color { get }
    var colorAccent: Color { get }
    var gradientStart: Color { get }
    var gradientEnd: Color { get }
}

protocol AppShadowTokens {
    var cardShadowColor: Color { get }
    var cardShadowRadius: CGFloat { get }
    var cardShadowX: CGFloat { get }
    var cardShadowY: CGFloat { get }
}


protocol AppOtherTokens {
    var cornerRadius: CGFloat { get }
    var iconMaxSize: CGSize { get }
    var cardMaterial: Material { get }
}

struct DefaultTokens: AppSpacingTokens, AppFontTokens, AppColorTokens, AppShadowTokens, AppOtherTokens {
    // Spacing
    let spacing4: CGFloat = 4
    let spacing5: CGFloat = 5
    let spacing8: CGFloat = 8
    let spacing10: CGFloat = 10
    let spacing20: CGFloat = 20
    let spacing25: CGFloat = 25
    let spacing30: CGFloat = 30
    let spacing40: CGFloat = 40
    
    // Fonts
    let fontSizeSmall: CGFloat = 14
    let fontSizeMedium: CGFloat = 20
    let fontSizeLarge: CGFloat = 34
    let fontSizeXLarge: CGFloat = 60
    let fontSizeXXLarge: CGFloat = 70
    
    // Colors
    let colorPrimary: Color = .white
    let colorSecondary: Color = .white.opacity(0.8)
    let colorAccent: Color = .yellow
    let gradientStart: Color = Color.blue.opacity(0.8)
    let gradientEnd: Color = Color.purple.opacity(0.7)
    
    // Shadows
    let cardShadowColor: Color = .black.opacity(0.25)
    let cardShadowRadius: CGFloat = 12
    let cardShadowX: CGFloat = 0
    let cardShadowY: CGFloat = 8

    // Otros
    let cornerRadius: CGFloat = 25
    let iconMaxSize: CGSize = CGSize(width: 100, height: 100)
    let cardMaterial: Material = .ultraThinMaterial
}

struct TokensKey: EnvironmentKey {
    static let defaultValue: DefaultTokens = DefaultTokens()
}

extension EnvironmentValues {
    var tokens: DefaultTokens {
        get { self[TokensKey.self] }
        set { self[TokensKey.self] = newValue }
    }
}
