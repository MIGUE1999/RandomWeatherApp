import XCTest
import Combine

@testable import RandomWeatherApp

final class WeatherDetailViewModelTests: XCTestCase {
    private var sut: WeatherDetailViewModel!
    private var getRandomLocationUseCaseMock: GetRandomLocationUseCaseMock!
    private var getWeatherUseCaseMock: GetWeatherUseCaseMock!
    private var imageDownloaderMock: ImageDownloaderMock!

    private var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        getRandomLocationUseCaseMock = GetRandomLocationUseCaseMock()
        getWeatherUseCaseMock = GetWeatherUseCaseMock()
        imageDownloaderMock = ImageDownloaderMock()
        sut = WeatherDetailViewModel(
            getRandomLocationUseCase: getRandomLocationUseCaseMock,
            getWeatherUseCase: getWeatherUseCaseMock,
            imageDownloader: imageDownloaderMock
        )
    }
    
    override func tearDown() {
        sut = nil
        getRandomLocationUseCaseMock = nil
        getWeatherUseCaseMock = nil
        imageDownloaderMock = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    func testLoadWeather_success() async {
        func testLoadWeather_success() async {
            // Given
            let location = LocationModel(latitude: 1.0, longitude: 2.0)
            let weather = WeatherModel(
                cityName: "MockCity",
                description: "Sunny",
                temperature: "25",
                iconURL: URL(filePath:"https://mock")
            )
            getRandomLocationUseCaseMock.result = location
            getWeatherUseCaseMock.result = weather

            let expectation = XCTestExpectation(description: "Wait for weather to be set")

            var cancellable: AnyCancellable?
            cancellable = sut.$weather
                .dropFirst()
                .sink { value in
                    if value != nil {
                        expectation.fulfill()
                    }
                }

            // When
            sut.loadWeather()

            await fulfillment(of: [expectation], timeout: 1.0)
            cancellable?.cancel()

            // Then
            XCTAssertEqual(sut.location?.latitude, 1.0)
            XCTAssertEqual(sut.location?.longitude, 2.0)
            XCTAssertEqual(sut.weather?.cityName, "MockCity")
            XCTAssertNil(sut.error)
            XCTAssertFalse(sut.isLoading)
        }

    }
    
    func testLoadWeather_error() async {
        // Given
        let location = LocationModel(latitude: 0, longitude: 0)
        getRandomLocationUseCaseMock.result = location
        getWeatherUseCaseMock.shouldThrowError = true

        // Creamos expectation
        let expectation = XCTestExpectation(description: "Wait for error to be set")

        var cancellable: AnyCancellable?
        cancellable = sut.$error
            .dropFirst()
            .sink { error in
                if error != nil {
                    expectation.fulfill()
                }
            }

        // When
        sut.loadWeather()

        // Esperamos
        await fulfillment(of: [expectation], timeout: 1.0)
        cancellable?.cancel()

        // Then
        XCTAssertNotNil(sut.error)
        XCTAssertNil(sut.weather)
    }

}
