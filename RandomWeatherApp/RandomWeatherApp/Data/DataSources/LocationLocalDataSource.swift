protocol LocationLocalDataSourceContract {
    func generateRandomLocation() -> LocationModel
}

final class LocationLocalDataSource: LocationLocalDataSourceContract {
    private var mapper: LocationEntityMapperContract
    
    init(mapper: LocationEntityMapperContract = LocationEntityMapper()) {
        self.mapper = mapper
    }
    
    func generateRandomLocation() -> LocationModel {
        let locationEntity = LocationEntity(
            latitude: .random(in: LocationRules.latitudeRange),
            longitude: .random(in: LocationRules.longitudeRange)
        )
        return mapper.map(from: locationEntity)
    }
}
