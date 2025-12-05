import XCTest

@testable import RandomWeatherApp

final class LocationRepositoryTests: XCTestCase {
    private var dataSourceMock: LocationLocalDataSourceMock!
    private var sut: LocationRepositoryContract!

    override func setUp() {
        super.setUp()
        dataSourceMock = LocationLocalDataSourceMock()
        sut = LocationRepository(locationLocalDataSource: dataSourceMock)
    }

    override func tearDown() {
        dataSourceMock = nil
        sut = nil
        super.tearDown()
    }

    func testGenerateRandomLocation_returnsValueFromDataSource() {
        // Given
        let expected = LocationModel(latitude: 12.34, longitude: 56.78)
        dataSourceMock.result = expected

        // When
        let value = sut.generateRandomLocation()

        // Then
        XCTAssertEqual(value.latitude, expected.latitude)
        XCTAssertEqual(value.longitude, expected.longitude)
    }
}
