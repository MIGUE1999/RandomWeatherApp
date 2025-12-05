import XCTest

@testable import RandomWeatherApp

final class WeatherEntityMapperTests: XCTestCase {

    var sut: WeatherEntityMapperContract!

    override func setUp() {
        super.setUp()
        sut = WeatherEntityMapper()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testMap_withValidWeather() {
        // Given
        let weatherCondition = WeatherEntity.WeatherCondition(description: "mock description", icon: "mockicon")
        let entity = WeatherEntity(name: "mock city", weather: [weatherCondition], main: WeatherEntity.MainInfo(temp: 0.0))

        // When
        do {
            let model = try sut.map(from: entity)
            
            // Then
            XCTAssertEqual(model.cityName, "mock city")
            XCTAssertEqual(model.description, "mock description")
            XCTAssertEqual(model.iconURL.absoluteString, "https://openweathermap.org/img/wn/mockicon@2x.png")
        } catch {
            fatalError("Non expected error")
        }
    }

    func testMap_withEmptyWeather() {
        // Given
        let entity = WeatherEntity(name: "mock",
                                   weather: [WeatherEntity.WeatherCondition(description:"mock", icon: "mock")],
                                   main: WeatherEntity.MainInfo(temp: 0.0))

        // When
        do {
            let model = try sut.map(from: entity)

            // Then
            XCTAssertEqual(model.cityName, "mock")
        } catch {
            fatalError("Non expected error \(error)")
        }
       
    }

    func testMap_withNilIcon() {
        // Given
        let weatherCondition = WeatherEntity.WeatherCondition(description: "mockdesc", icon: nil)
        let entity = WeatherEntity(name: "mockname", weather: [weatherCondition], main: WeatherEntity.MainInfo(temp: 0.0))

        // When
        do {
            _ = try sut.map(from: entity)
        } catch let error as MapperError {
            XCTAssertEqual(error, MapperError.invalidUrl)
        } catch {
            fatalError("Non expected error \(error)")
        }
    }
}
