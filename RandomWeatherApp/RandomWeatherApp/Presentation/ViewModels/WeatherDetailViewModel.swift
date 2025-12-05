import Foundation
import Combine
import SwiftUI

protocol WeatherDetailViewModelContract: ObservableObject {
    func loadWeather()
}

final class WeatherDetailViewModel: WeatherDetailViewModelContract {
    private let getRandomLocationUseCase: GetRandomLocationUseCaseContract
    private let getWeatherUseCase: GetWeatherUseCaseContract
    private let imageDownloader: ImageDownloaderContract
    
    private var loadWeatherTask: Task<Void, Never>?
    private var cancellables = Set<AnyCancellable>()
    
    @Published var weather: WeatherModel? = nil
    @Published var location: LocationModel? = nil
    @Published var isLoading: Bool = true
    @Published private var _isLoadingRaw: Bool = false
    @Published var error: Error? = nil
    
    init(getRandomLocationUseCase: GetRandomLocationUseCaseContract = GetRandomLocationUseCase(),
         getWeatherUseCase: GetWeatherUseCaseContract = GetWeatherUseCase(),
         imageDownloader: ImageDownloaderContract = ImageDownloader()) {
        self.getRandomLocationUseCase = getRandomLocationUseCase
        self.getWeatherUseCase = getWeatherUseCase
        self.imageDownloader = imageDownloader
        self.setup()
    }
    
    deinit {
        loadWeatherTask?.cancel()
    }
    
    func loadWeather() {
        self.error = nil
        _isLoadingRaw = true
        loadWeatherTask?.cancel()

        loadWeatherTask = Task { @MainActor [weak self] in
            defer {
                self?._isLoadingRaw = false
            }
            do {
                guard let location = self?.getRandomLocationUseCase.run(),
                      let weather = try await self?.getWeatherUseCase.run(location: LocationModel(latitude: location.latitude,
                                                                                            longitude: location.longitude))
                else {
                    return
                }

                self?.weather = weather
                self?.location = location
            } catch {
                self?.error = error
            }
        }
    }
}

private extension WeatherDetailViewModel {
    private func setup() {
        $_isLoadingRaw
            .removeDuplicates()
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .sink { [weak self] value in
                self?.isLoading = value
            }
            .store(in: &cancellables)
    }
}
