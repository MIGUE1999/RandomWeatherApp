protocol LocationEntityMapperContract {
    func map(from locationEntity: LocationEntity) -> LocationModel
}

final class LocationEntityMapper: LocationEntityMapperContract {
    func map(from locationEntity: LocationEntity) -> LocationModel {
        return LocationModel(
            latitude: locationEntity.latitude,
            longitude: locationEntity.longitude
        )
    }
}
