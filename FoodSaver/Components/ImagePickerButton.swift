import SwiftUI

struct ImagePickerButton: View {
    @Binding var temporaryFoodItem: FoodItemTemp

    var body: some View {
        Button(action: {
            temporaryFoodItem.showImagePicker = true
        }) {
            if let imageData = temporaryFoodItem.picture, let image = UIImage(data: imageData) {
                Image(uiImage: image)
                    .makeFoodViewPhotoBox()
            } else {
                Image(systemName: "camera.fill")
                    .makeFoodViewPhotoBox()
                    .foregroundColor(.gray)
            }
        }
        .sheet(isPresented: $temporaryFoodItem.showImagePicker) {
            ImagePicker(image: $temporaryFoodItem.inputImage, sourceType: .camera)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
