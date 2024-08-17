import SwiftUI
import SwiftData

struct AddModifyItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var context
    @State private var temporaryFoodItem: FoodItemTemp

    var originalFoodItem: FoodItem?
    var isNewItem: Bool

    init(foodItem: FoodItem? = nil) {
        if let foodItem = foodItem {
            self.originalFoodItem = foodItem
            self._temporaryFoodItem = State(initialValue: FoodItemTemp(from: foodItem))
            self.isNewItem = false
        } else {
            self._temporaryFoodItem = State(initialValue: FoodItemTemp())
            self.isNewItem = true
        }
    }

    var body: some View {
        ScrollView {
            VStack {
                Text(isNewItem ? "Add Food Item" : "Modify Food Item")
                    .font(.largeTitle)
                    .padding()

                TextField("Item Name", text: $temporaryFoodItem.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    temporaryFoodItem.showImagePicker = true
                }) {
                    if let imageData = temporaryFoodItem.picture, let image = UIImage(data: imageData) {
                        Image(uiImage: image)
                            .makeFoodViewPhotoBox()
                    } else {
                        Image(systemName: "camera.fill")
                            .makeFoodViewPhotoBox()
                    }
                }
                .sheet(isPresented: $temporaryFoodItem.showImagePicker) {
                    ImagePicker(image: $temporaryFoodItem.inputImage, sourceType: .camera)
                        .edgesIgnoringSafeArea(.all)
                }
                .onChange(of: temporaryFoodItem.inputImage) {
                    loadImage()
                }

                DatePicker("Best Before Date", selection: $temporaryFoodItem.bestBeforeDate, displayedComponents: .date)
                    .padding()

                DatePicker("Purchase Date", selection: $temporaryFoodItem.purchaseDate, displayedComponents: .date)
                    .padding()

                TextField("Category", text: $temporaryFoodItem.category)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Location", text: $temporaryFoodItem.location)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Spacer()

                HStack {
                    Button("Back") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding()

                    Button("Save") {
                        saveChanges()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding()
                }
            }
        }
        .padding(.bottom, 50)
    }

    private func loadImage() {
        guard let inputImage = temporaryFoodItem.inputImage else { return }
        temporaryFoodItem.picture = inputImage.jpegData(compressionQuality: 0.8)
    }

    private func saveChanges() {
        if isNewItem {
            let newItem = FoodItem()
            updateModel(newItem)
            context.insert(newItem)
        } else if let original = originalFoodItem {
            updateModel(original)
        }

        try? context.save()
    }

    private func updateModel(_ foodItem: FoodItem) {
        foodItem.name = temporaryFoodItem.name
        foodItem.picture = temporaryFoodItem.picture
        foodItem.bestBeforeDate = temporaryFoodItem.bestBeforeDate
        foodItem.purchaseDate = temporaryFoodItem.purchaseDate
        foodItem.category = temporaryFoodItem.category
        foodItem.location = temporaryFoodItem.location
    }
}
