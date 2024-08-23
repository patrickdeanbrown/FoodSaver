import SwiftUI
import SwiftData

struct AddModifyItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var context
    @State private var temporaryFoodItem: FoodItemTemp

    var originalFoodItem: FoodItem?
    var isNewItem: Bool

    let categories = [
        "Fresh Produce": 3,
        "Dairy Products": 7,
        "Meat and Seafood": 2,
        "Bread and Bakery": 5,
        "Packaged Snacks": 30,
        "Frozen Goods": 60,
        "Canned Goods": 180,
        "Condiments and Sauces": 90,
        "Grains and Rice": 90,
        "Beverages": 10
    ]
    
    let locations = ["Fridge", "Cupboard", "Freezer", "Shelves", "Other"]

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

                Text("Item Name")
                    .font(.headline)
                TextField("Enter item name", text: $temporaryFoodItem.name)
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

                Text("Best Before Date")
                    .font(.headline)
                DatePicker("Select a Date", selection: $temporaryFoodItem.bestBeforeDate, displayedComponents: .date)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()

                Text("Category")
                    .font(.headline)
                Picker("Select category", selection: $temporaryFoodItem.category) {
                    ForEach(categories.keys.sorted(), id: \.self) { category in
                        Text(category).tag(category)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                .onChange(of: temporaryFoodItem.category) { category in
                    temporaryFoodItem.warningPeriod = categories[category] ?? 0
                }

                Text("Location")
                    .font(.headline)
                Picker("Select location", selection: $temporaryFoodItem.location) {
                    ForEach(locations, id: \.self) { location in
                        Text(location).tag(location)
                    }
                }
                .pickerStyle(MenuPickerStyle())
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
        foodItem.category = temporaryFoodItem.category
        foodItem.location = temporaryFoodItem.location
        foodItem.warningPeriod = temporaryFoodItem.warningPeriod
    }
}
