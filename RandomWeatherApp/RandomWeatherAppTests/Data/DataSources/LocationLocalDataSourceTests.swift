import XCTest

@testable import RandomWeatherApp

final class LocationLocalDataSourceTests: XCTestCase {
    var mapper: LocationEntityMapperContract!
    var sut: LocationLocalDataSourceContract!

    override func setUp() {
        super.setUp()
        mapper = LocationEntityMapper()
        sut = LocationLocalDataSource(mapper: mapper)
    }

    override func tearDown() {
        mapper = nil
        sut = nil
        super.tearDown()
    }

    func testGenerateRandomLocation_returnsLocationWithinValidRange() {
        // When
        let location = sut.generateRandomLocation()

        // Then
        XCTAssertTrue(LocationRules.latitudeRange.contains(location.latitude),
                      "Latitude \(location.latitude) is out of range")
        XCTAssertTrue(LocationRules.longitudeRange.contains(location.longitude),
                      "Longitude \(location.longitude) is out of range")
    }
}
