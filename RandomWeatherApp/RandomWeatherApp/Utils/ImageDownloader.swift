import Foundation
import SwiftUI

protocol ImageDownloaderContract {
    func download(from url: URL) async -> UIImage?
}

final class ImageDownloader: ImageDownloaderContract {
    func download(from url: URL) async -> UIImage? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            return nil
        }
    }
}
