import SwiftUI

struct WeatherCardView: View {
    let iconImage: URL?
    let temperature: String
    let latitude: String
    let longitude: String
    @Environment(\.tokens) private var tokens
    
    var body: some View {
        VStack(spacing: tokens.spacing25) {
            AsyncImage(url: iconImage) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(
                            maxWidth: tokens.iconMaxSize.width,
                            maxHeight: tokens.iconMaxSize.height
                        )
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: tokens.iconMaxSize.width, maxHeight: tokens.iconMaxSize.height)
                        .foregroundColor(tokens.colorAccent)
                        .accessibilityHidden(true)
                case .failure:
                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.red)
                        .frame(
                            maxWidth: tokens.iconMaxSize.width,
                            maxHeight: tokens.iconMaxSize.height
                        )
                        .accessibilityLabel("Error loading image")
                    
                @unknown default:
                    EmptyView()
                }
            }
            
            Text(temperature + Constants.temperatureUnit)
                .font(.system(size: tokens.fontSizeXXLarge, weight: .bold))
                .foregroundColor(tokens.colorPrimary)
                .multilineTextAlignment(.center)
                .accessibilityLabel(Constants.temperatureLabel11y)
                .accessibilityValue(temperature)
            
            HStack(spacing: tokens.spacing30) {
                VStack(spacing: tokens.spacing4) {
                    Text(Constants.latitudeLabel)
                        .font(.system(size: tokens.fontSizeMedium, weight: .bold))
                        .foregroundColor(tokens.colorSecondary)
                        .multilineTextAlignment(.center)
                    Text(latitude)
                        .font(.body.bold())
                        .foregroundColor(tokens.colorPrimary)
                        .accessibilityLabel(Constants.latitudeLabela11y)
                        .accessibilityValue(latitude)
                        .lineLimit(nil)
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                }
                
                VStack(spacing: tokens.spacing4) {
                    Text(Constants.longitudeLabel)
                        .font(.system(size: tokens.fontSizeMedium, weight: .bold))
                        .foregroundColor(tokens.colorSecondary)
                        .multilineTextAlignment(.center)
                    Text(longitude)
                        .font(.body.bold())
                        .foregroundColor(tokens.colorPrimary)
                        .accessibilityLabel(Constants.longitudeLabel11y)
                        .lineLimit(nil)
                        .accessibilityValue(longitude)
                        .minimumScaleFactor(Constants.scaleFactor)
                        .multilineTextAlignment(.center)
                }
            }
            .accessibilityElement(children: .combine)
            
        }
        .padding(tokens.spacing25)
        .background(tokens.cardMaterial)
        .cornerRadius(tokens.cornerRadius)
        .shadow(color: tokens.cardShadowColor, radius: tokens.cardShadowRadius, x: tokens.cardShadowX, y: tokens.cardShadowY)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(Constants.weatherCardLabel11y)
        .accessibilityAddTraits(.isSummaryElement)
    }
    
    private struct Constants {
        static let latitudeLabel: String = "Lat"
        static let longitudeLabel: String = "Long"
        static let temperatureLabel11y: String = "Current Temperature"
        static let weatherCardLabel11y: String = "Weather Card"
        static let latitudeLabela11y: String = "Latitude"
        static let longitudeLabel11y: String = "Longitude"
        static let scaleFactor: Double = 0.5
        static let temperatureUnit: String = "°C"
    }
}
