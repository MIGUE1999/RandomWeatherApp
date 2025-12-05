protocol WeatherRepositoryContract {
    func getWeather(location: LocationModel) async throws -> WeatherModel
}

final class WeatherRepository: WeatherRepositoryContract {
    private var remoteDataSource: WeatherRemoteDataSourceContract
    
    init(remoteDataSource: WeatherRemoteDataSourceContract = WeatherRemoteDataSource()) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getWeather(location: LocationModel) async throws -> WeatherModel {
        return try await remoteDataSource.getWeather(location: location)
    }
}
