import XCTest

@testable import RandomWeatherApp

final class WeatherRepositoryTests: XCTestCase {
    private var dataSourceMock: WeatherRemoteDataSourceMock!
    private var sut: WeatherRepositoryContract!

    override func setUp() {
        super.setUp()
        dataSourceMock = WeatherRemoteDataSourceMock()
        sut = WeatherRepository(remoteDataSource: dataSourceMock)
    }

    override func tearDown() {
        dataSourceMock = nil
        sut = nil
        super.tearDown()
    }

    func testGetWeather_returnsWeatherFromDataSource() async throws {
        // Given
        let expected = WeatherModel(
            cityName: "Madrid",
            description: "Clear sky",
            temperature: "Mock Temperature",
            iconURL: URL(string: "https://example.com/icon.png")!
        )
        dataSourceMock.result = expected

        let location = LocationModel(latitude: 40.4, longitude: -3.7)

        // When
        let result = try await sut.getWeather(location: location)

        // Then
        XCTAssertEqual(result.cityName, expected.cityName)
        XCTAssertEqual(result.description, expected.description)
        XCTAssertEqual(result.temperature, expected.temperature)
        XCTAssertEqual(result.iconURL, expected.iconURL)
    }
}

