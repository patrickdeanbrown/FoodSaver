import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false

    var body: some View {
        VStack {
            if isActive {
                ContentView()
            } else {
                VStack {
                    Text("Food Saver")
                        .font(.largeTitle)
                        .bold()
                    Image(systemName: "fork.knife.circle")
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.5)) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isActive = true
                        }
                    }
                }
            }
        }
    }
}
