protocol LocationRepositoryContract {
    func generateRandomLocation() -> LocationModel
}

final class LocationRepository: LocationRepositoryContract {
    private var locationLocalDataSource: LocationLocalDataSourceContract
    
    init(locationLocalDataSource: LocationLocalDataSourceContract = LocationLocalDataSource()) {
        self.locationLocalDataSource = locationLocalDataSource
    }
    func generateRandomLocation() -> LocationModel {
        locationLocalDataSource.generateRandomLocation()
    }    
}
