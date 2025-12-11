import SwiftUI

struct ImagePickerButton: View {
    @Binding var temporaryFoodItem: FoodItemTemp

    private var availableSourceType: UIImagePickerController.SourceType {
        UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
    }

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
                    .foregroundColor(Theme.textTertiary)
            }
        }
        .accessibilityLabel("Add or change photo")
        .sheet(isPresented: $temporaryFoodItem.showImagePicker) {
            ImagePicker(image: $temporaryFoodItem.inputImage, sourceType: availableSourceType)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
