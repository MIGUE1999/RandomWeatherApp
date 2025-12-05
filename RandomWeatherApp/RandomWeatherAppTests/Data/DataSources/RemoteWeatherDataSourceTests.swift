import Foundation
import XCTest

@testable import RandomWeatherApp

final class RemoteWeatherDataSourceTests: XCTestCase {

    var serviceMock: WeatherServiceMock!
    var mapperMock: WeatherEntityMapperMock!
    var sut: WeatherRemoteDataSourceContract!

    override func setUp() {
        super.setUp()
        serviceMock = WeatherServiceMock()
        mapperMock = WeatherEntityMapperMock()
        sut = WeatherRemoteDataSource(service: serviceMock, mapper: mapperMock)
    }

    override func tearDown() {
        serviceMock = nil
        mapperMock = nil
        sut = nil
        super.tearDown()
    }

    func testGetWeather_success() async throws {
        // Given
        let jsonString = """
        {
            "name": "mockName",
            "weather": [
                {
                    "description": "mockDesc",
                    "icon": "01d"
                }
            ],
            "main": {
                "temp": 23.5
            },
            "currentCondition": {
                "description": "mockDesc",
                "icon": "01d"
            }
        }
        """
        let data = jsonString.data(using: .utf8)!
        serviceMock.dataToReturn = data

        let expectedModel = WeatherModel(cityName: "mockName",
                                         description: "mockDesc",
                                         temperature: "mockTemp",
                                         iconURL: URL(string: "https://openweathermap.org/img/wn/01d@2x.png")!)
        mapperMock.modelToReturn = expectedModel

        let location = LocationModel(latitude: 0, longitude: 0)

        // When
        let result = try await sut.getWeather(location: location)

        // Then
        XCTAssertEqual(result.cityName, expectedModel.cityName)
        XCTAssertEqual(result.description, expectedModel.description)
        XCTAssertEqual(result.iconURL, expectedModel.iconURL)

        XCTAssertNotNil(mapperMock.mapCalledWith)
        XCTAssertEqual(mapperMock.mapCalledWith?.name, "mockName")
    }

    func testGetWeather_decodingFails() async {
        // Given
        let invalidJSON = "{ invalid json }".data(using: .utf8)!
        serviceMock.dataToReturn = invalidJSON
        let location = LocationModel(latitude: 0, longitude: 0)

        // When / Then
        do {
            _ = try await sut.getWeather(location: location)
            XCTFail("Waiting for decoding error")
        } catch let error as WeatherError {
            XCTAssertEqual(error, WeatherError.decodingFailed)
        } catch {
            XCTFail("Unexpected Error")
        }
    }

    func testGetWeather_serviceThrows() async {
        // Given
        serviceMock.errorToThrow = URLError(.notConnectedToInternet)
        let location = LocationModel(latitude: 0, longitude: 0)

        // When / Then
        do {
            _ = try await sut.getWeather(location: location)
            XCTFail("Waiting for service error")
        } catch let error as URLError {
            XCTAssertEqual(error.code, .notConnectedToInternet)
        } catch {
            XCTFail("Unexpected Error")
        }
    }
}

