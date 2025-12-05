import XCTest

@testable import RandomWeatherApp

final class GetRandomLocationUseCaseTests: XCTestCase {
    private var sut: GetRandomLocationUseCaseContract!
    private var mockLocationRepository: LocationRepositoryMock!

    override func setUp() async throws {
        try await super.setUp()
        mockLocationRepository = LocationRepositoryMock()
        sut = GetRandomLocationUseCase(locationRepository: mockLocationRepository)
    }
    
    func testRun_returnsLocationFromRepository() {
        // Given
        mockLocationRepository.result = LocationModel(latitude: 1.0, longitude: 2.0)
        let expectedLocation = LocationModel(latitude: 1.0, longitude: 2.0)

        // When
        let result = sut.run()

        // Then
        XCTAssertEqual(result.latitude, expectedLocation.latitude)
        XCTAssertEqual(result.longitude, expectedLocation.longitude)
    }
}

