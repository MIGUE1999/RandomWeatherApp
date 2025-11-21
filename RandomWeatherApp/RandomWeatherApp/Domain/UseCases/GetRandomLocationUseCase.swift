protocol GetRandomLocationUseCaseContract {
    func run() -> LocationModel
}

final class GetRandomLocationUseCase: GetRandomLocationUseCaseContract {
    private var locationRepository: LocationRepositoryContract
    
    init(locationRepository: LocationRepositoryContract = LocationRepository()) {
        self.locationRepository = locationRepository
    }
    
    func run() -> LocationModel {
        locationRepository.generateRandomLocation()
    }
}
