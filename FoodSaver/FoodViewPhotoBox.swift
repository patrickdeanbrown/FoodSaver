import SwiftUI

extension Image {
    func makeFoodViewPhotoBox() -> some View {
        return self.resizable()
            .scaledToFit()
            .frame(height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2))
    }
}
