// SplashScreenView.swift
import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @State private var animateLogo = false

    var body: some View {
        VStack {
            if isActive {
                ContentView()
                    .transition(.opacity)
            } else {
                VStack {
                    Text("Food Saver")
                        .font(Theme.titleFont)
                        .foregroundColor(Theme.primaryColor)
                        .scaleEffect(animateLogo ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: animateLogo)
                    
                    Image(systemName: "fork.knife.circle")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(Theme.accentColor)
                        .scaleEffect(animateLogo ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: animateLogo)
                }
                .onAppear {
                    animateLogo = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            isActive = true
                        }
                    }
                }
            }
        }
    }
}
