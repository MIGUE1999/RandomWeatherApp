import Foundation
import Combine

protocol RandomLocationViewModelContract: ObservableObject {
    func didTapRandomLocation()
}

final class RandomLocationViewModel: RandomLocationViewModelContract {
    private var getRandomLocationUseCase: GetRandomLocationUseCaseContract
    
    @Published
    var randomLatitude: Double?
    
    @Published
    var randomLongitude: Double?
    
    init(getRandomLocationUseCase: GetRandomLocationUseCaseContract = GetRandomLocationUseCase()) {
        self.getRandomLocationUseCase = getRandomLocationUseCase
    }
    
    func didTapRandomLocation() {
        let randomLocation = getRandomLocationUseCase.run()
        randomLatitude = randomLocation.latitude
        randomLongitude = randomLocation.longitude
    }
}

