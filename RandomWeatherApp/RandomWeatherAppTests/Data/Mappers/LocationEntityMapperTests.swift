import XCTest

@testable import RandomWeatherApp

final class LocationEntityMapperTests: XCTestCase {

    var sut: LocationEntityMapperContract!

    override func setUp() {
        super.setUp()
        sut = LocationEntityMapper()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testMap_returnsCorrectLocationModel() {
        // Given
        let entity = LocationEntity(latitude: 12.34, longitude: 56.78)

        // When
        let model = sut.map(from: entity)

        // Then
        XCTAssertEqual(model.latitude, 12.34)
        XCTAssertEqual(model.longitude, 56.78)
    }

    func testMap_withNegativeCoordinates() {
        // Given
        let entity = LocationEntity(latitude: -45.0, longitude: -90.0)

        // When
        let model = sut.map(from: entity)

        // Then
        XCTAssertEqual(model.latitude, -45.0)
        XCTAssertEqual(model.longitude, -90.0)
    }

    func testMap_withZeroCoordinates() {
        // Given
        let entity = LocationEntity(latitude: 0.0, longitude: 0.0)

        // When
        let model = sut.map(from: entity)

        // Then
        XCTAssertEqual(model.latitude, 0.0)
        XCTAssertEqual(model.longitude, 0.0)
    }
}
