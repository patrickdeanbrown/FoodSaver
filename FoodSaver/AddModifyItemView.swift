import SwiftUI

struct AddModifyItemView: View {
    @ObservedObject var viewModel: FoodViewModel
    @ObservedObject var foodItem: FoodItem

    @Environment(\.presentationMode) var presentationMode
    @State private var showImagePicker = false
    @State private var inputImage: UIImage?

    var body: some View {
        ScrollView {
            VStack {
                Text("Add/Modify Food Item")
                    .font(.largeTitle)
                    .padding()

                TextField("Item Name", text: $foodItem.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    showImagePicker = true
                }) {
                    if let imageData = foodItem.picture, let image = UIImage(data: imageData) {
                        Image(uiImage: image)
                            .makeFoodViewPhotoBox()
                    } else {
                        Image(systemName: "camera.fill")
                            .makeFoodViewPhotoBox()
                    }
                }
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(image: $inputImage, sourceType: .camera)
                }
                .onChange(of: inputImage) {
                    loadImage()
                }

                DatePicker("Best Before Date", selection: $foodItem.bestBeforeDate, displayedComponents: .date)
                    .padding()

                DatePicker("Purchase Date", selection: $foodItem.purchaseDate, displayedComponents: .date)
                    .padding()

                TextField("Category", text: $foodItem.category)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Location", text: $foodItem.location)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Spacer()

                HStack {
                    Button("Back") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding()

                    Button("Save") {
                        viewModel.saveContext()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding()
                }
            }
        }
        .padding(.bottom, 50)  // Add padding to prevent overlap with keyboard
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        foodItem.picture = inputImage.jpegData(compressionQuality: 0.8)
    }
}
