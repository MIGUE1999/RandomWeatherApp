import SwiftUI

struct CityHeaderView: View {
    let city: String
    let description: String
    @Environment(\.tokens) private var tokens

    var body: some View {
        VStack(spacing: tokens.spacing8) {
            Text(city)
                .font(.system(size: tokens.fontSizeXLarge, weight: .bold))
                .foregroundColor(tokens.colorPrimary)
                .lineLimit(nil)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
                .accessibilityLabel(Strings.cityLabela11y)
                .accessibilityValue(city)
                .accessibilityAddTraits(.isHeader)
            
            Text(description)
                .font(.system(size: tokens.fontSizeMedium))
                .foregroundColor(tokens.colorSecondary)
                .lineLimit(nil)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
                .accessibilityLabel(Strings.descriptionLabela11y)
                .accessibilityValue(description)
        }
        .accessibilityElement(children: .combine)
    }
    
    private struct Strings {
        static let cityLabela11y: String = "City"
        static let descriptionLabela11y: String = "Weather Description"
    }
}
