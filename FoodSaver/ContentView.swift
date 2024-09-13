import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            MainView()
                .navigationTitle("Food Saver")
        }
        .preferredColorScheme(.light) // Apply the color scheme here
    }
}
