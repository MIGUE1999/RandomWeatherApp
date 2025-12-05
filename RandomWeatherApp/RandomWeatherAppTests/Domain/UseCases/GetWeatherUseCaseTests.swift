import XCTest
@testable import RandomWeatherApp

final class GetWeatherUseCaseTests: XCTestCase {
    private var sut: GetWeatherUseCaseContract!
    private var mockWeatherRepository: WeatherRepositoryMock!

    override func setUp() async throws {
        try await super.setUp()
        mockWeatherRepository = WeatherRepositoryMock()
        sut = GetWeatherUseCase(weatherRepository: mockWeatherRepository)
    }
    
    func testRun_returnsWeatherFromRepository() async throws {
        // Given
        let expectedWeather = WeatherModel(
            cityName: "MockCity",
            description: "MockDescription",
            temperature: "20°C",
            iconURL: URL(string: "https://example.com/icon.png")!
        )
        mockWeatherRepository.result = expectedWeather
        let location = LocationModel(latitude: 0, longitude: 0)
        
        // When
        let result = try await sut.run(location: location)
        
        // Then
        XCTAssertEqual(result.cityName, expectedWeather.cityName)
        XCTAssertEqual(result.description, expectedWeather.description)
        XCTAssertEqual(result.temperature, expectedWeather.temperature)
        XCTAssertEqual(result.iconURL, expectedWeather.iconURL)
    }
    
    func testRun_throwsErrorWhenRepositoryFails() async {
        // Given
        mockWeatherRepository.shouldThrowError = true
        let location = LocationModel(latitude: 0, longitude: 0)
        
        // Then
        do {
            _ = try await sut.run(location: location)
            XCTFail("Expected error")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }

}
