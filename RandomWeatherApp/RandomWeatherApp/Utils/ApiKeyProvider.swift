import Foundation

enum APIKeyProvider {
    private static let p1 = "b273076"
    private static let p2 = "df6a1471d161"
    private static let p3 = "35e4f2cd8c6be"

    static var apiKey: String {
        return p1 + p2 + p3
    }
}
