import SwiftUI
import XCTest

@testable import RandomWeatherApp

final class ImageDownloaderMock: ImageDownloaderContract {
    var result: UIImage? = nil
    var downloadCalled = false

    func download(from url: URL) async -> UIImage? {
        downloadCalled = true
       guard let result = result else {
           fatalError("Expected result in ImageDonloaderMock")
       }

        return result
    }
}
