import SwiftUI

extension Image {
    func makeFoodViewPhotoBox() -> some View {
        self.resizable()
            .scaledToFit()
            .frame(height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .background(Theme.surfaceAlt)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Theme.border, lineWidth: 1))
    }
}
