import XCTest

@testable import RandomWeatherApp

final class WeatherServiceTests: XCTestCase {
    var sessionMock: URLSessionMock!
    var sut: WeatherServiceContract!

    override func setUp() {
        super.setUp()
        sessionMock = URLSessionMock()
        sut = WeatherService(session: sessionMock)
    }

    override func tearDown() {
        sessionMock = nil
        sut = nil
        super.tearDown()
    }

    func testFetchWeather_success() async throws {
        // Given
        let jsonString = """
        {
            "name": "Mock City",
            "weather": [{"description": "Mock Description", "icon": "Mock Icon"}],
            "main": {"temp": 25.0}
        }
        """

        sessionMock.data = jsonString.data(using: .utf8)
        sessionMock.response = HTTPURLResponse(
            url: URL(string: "https://api.openweathermap.org/data/2.5/weather")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        let location = LocationModel(latitude: 0, longitude: 0)
        
        // When
        let data = try await sut.fetchWeather(location: location)

        // Then
        let entity = try JSONDecoder().decode(WeatherEntity.self, from: data)
        XCTAssertEqual(entity.name, "Mock City")
        XCTAssertEqual(entity.currentCondition?.description, "Mock Description")
        XCTAssertEqual(entity.currentCondition?.icon, "Mock Icon")
    }

    func testFetchWeather_httpError() async {
        // Given
        sessionMock.data = Data()
        sessionMock.response = HTTPURLResponse(
            url: URL(string: "https://api.openweathermap.org/data/2.5/weather")!,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )

        let location = LocationModel(latitude: 0, longitude: 0)
        // When
        do {
            _ = try await sut.fetchWeather(location: location)
            XCTFail("Se esperaba error HTTP")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }

    func testFetchWeather_badResponse() async {
        // Given
        sessionMock.data = Data()
        sessionMock.response = URLResponse()

        let location = LocationModel(latitude: 0, longitude: 0)

        // When
        do {
            _ = try await sut.fetchWeather(location: location)
            XCTFail("Waiting for error bad response")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }

    func testFetchWeather_networkError() async {
        // Given
        sessionMock.error = URLError(.notConnectedToInternet)

        let location = LocationModel(latitude: 0, longitude: 0)

        // When
        do {
            _ = try await sut.fetchWeather(location: location)
            XCTFail("Waiting for network error")
        } catch let error as URLError {
            XCTAssertEqual(error.code, .notConnectedToInternet)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
