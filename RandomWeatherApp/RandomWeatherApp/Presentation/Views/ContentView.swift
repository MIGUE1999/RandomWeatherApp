import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RandomLocationViewModel()
    
    var body: some View {
        VStack {
            Button("Get Random Location") {
                viewModel.didTapRandomLocation()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())

            HStack {
                Text("Latitude: \(viewModel.randomLatitude.map { String(format: "%.5f", $0) } ?? "N/A")")
                Text("Longitud: \(viewModel.randomLongitude.map{ String(format: "%.5f", $0) } ?? "N/A")")
            }
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
