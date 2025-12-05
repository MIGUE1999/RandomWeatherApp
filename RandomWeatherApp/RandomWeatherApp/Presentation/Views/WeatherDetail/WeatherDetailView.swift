import SwiftUI

struct WeatherDetailView: View {
    @StateObject private var viewModel = WeatherDetailViewModel()
    @Environment(\.tokens) private var tokens
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [tokens.gradientStart, tokens.gradientEnd]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            .accessibility(hidden: true)
            
            content
        }
        .onAppear {
            viewModel.loadWeather()
        }
    }
    
    @ViewBuilder
    private var content: some View {
        if let error = viewModel.error {
            ErrorView(title: Strings.errorTitle, message: error.localizedDescription) {
                viewModel.loadWeather()
            }
        } else if viewModel.isLoading {
            ProgressView(Strings.progressViewLabel)
                .font(.title2)
                .foregroundColor(.white)
        } else {
            VStack(spacing: tokens.spacing40) {
                Spacer()
                
                CityHeaderView(city: viewModel.weather?.cityName ?? "", description: viewModel.weather?.description ?? "")
                
                WeatherCardView(
                    iconImage: viewModel.weather?.iconURL,
                    temperature: viewModel.weather?.temperature ?? "",
                    latitude: String(format: "%.5f", viewModel.location?.latitude ?? 0),
                    longitude: String(format: "%.5f", viewModel.location?.longitude ?? 0)
                )
                
                Spacer()
                
                Button(action: { viewModel.loadWeather() }) {
                    Text(Strings.buttonLabel)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.2))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                .padding(.horizontal, tokens.spacing25)
            }
            .padding(tokens.spacing25)
        }
    }
    
    private struct Strings {
        static let progressViewLabel = "Loading weather…"
        static let buttonLabel = "Get new random weather"
        static let errorTitle = "Error"
    }
}

// MARK: - Preview
struct WeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailView()
            .environment(\.tokens, DefaultTokens())
    }
}
