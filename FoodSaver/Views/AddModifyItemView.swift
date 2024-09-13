// AddModifyItemView.swift
import SwiftUI
import SwiftData
import ConfettiSwiftUI

struct AddModifyItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var context
    @State private var temporaryFoodItem: FoodItemTemp
    @FocusState private var isInputActive: Bool
    
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
    
    // Confetti counter
    @State private var confettiCounter: Int = 0
    
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
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text(isNewItem ? "Add Food Item" : "Modify Food Item")
                        .font(Theme.titleFont)
                        .foregroundColor(Theme.primaryColor)
                        .padding(.top)
                    
                    // Item Name with Autocomplete
                    VStack(alignment: .leading) {
                        Text("Item Name")
                            .font(Theme.headlineFont)
                            .foregroundColor(Theme.secondaryColor)
                        TextField("Enter item name", text: $temporaryFoodItem.name)
                            .focused($isInputActive)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.vertical, 5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(isInputActive ? Theme.accentColor : Color.gray, lineWidth: 1)
                            )
                            .autocapitalization(.words)
                    }
                    .padding(.horizontal)
                    
                    // Image Picker
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
                    .onChange(of: temporaryFoodItem.inputImage) { _ in
                        loadImage()
                    }
                    
                    // Best Before Date Picker
                    VStack(alignment: .leading) {
                        Text("Best Before Date")
                            .font(Theme.headlineFont)
                            .foregroundColor(Theme.secondaryColor)
                        DatePicker("Select a Date", selection: $temporaryFoodItem.bestBeforeDate, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .padding(.vertical, 5)
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    
                    // Category Picker
                    VStack(alignment: .leading) {
                        Text("Category")
                            .font(Theme.headlineFont)
                            .foregroundColor(Theme.secondaryColor)
                        Menu {
                            ForEach(categories.keys.sorted(), id: \.self) { category in
                                Button(action: {
                                    temporaryFoodItem.category = category
                                    temporaryFoodItem.warningPeriod = categories[category] ?? 0
                                }) {
                                    Text(category)
                                }
                            }
                        } label: {
                            HStack {
                                Text(temporaryFoodItem.category.isEmpty ? "Select category" : temporaryFoodItem.category)
                                    .foregroundColor(temporaryFoodItem.category.isEmpty ? .gray : .primary)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Location Picker
                    VStack(alignment: .leading) {
                        Text("Location")
                            .font(Theme.headlineFont)
                            .foregroundColor(Theme.secondaryColor)
                        Menu {
                            ForEach(locations, id: \.self) { location in
                                Button(action: {
                                    temporaryFoodItem.location = location
                                }) {
                                    Text(location)
                                }
                            }
                        } label: {
                            HStack {
                                Text(temporaryFoodItem.location.isEmpty ? "Select location" : temporaryFoodItem.location)
                                    .foregroundColor(temporaryFoodItem.location.isEmpty ? .gray : .primary)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    // Action Buttons
                    HStack(spacing: 20) {
                        // Cancel Button
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "xmark.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                                .padding()
                                .background(Theme.accentColor)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .accessibilityLabel("Cancel")
                        
                        Spacer()
                        
                        // Save Button
                        Button(action: {
                            saveChanges()
                            if isNewItem {
                                triggerConfetti()
                            }
                            // Delay dismissal to allow confetti to display
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }) {
                            Image(systemName: "tray.and.arrow.down.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                                .padding()
                                .background(Theme.accentColor)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .accessibilityLabel("Save")
                    }
                    .padding(.horizontal)
                }
            }
            .navigationBarHidden(true)
            .confettiCannon(counter: $confettiCounter, num: 50, radius: 300.0)
        }
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
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }

    private func updateModel(_ foodItem: FoodItem) {
        foodItem.name = temporaryFoodItem.name
        foodItem.picture = temporaryFoodItem.picture
        foodItem.bestBeforeDate = temporaryFoodItem.bestBeforeDate
        foodItem.category = temporaryFoodItem.category
        foodItem.location = temporaryFoodItem.location
        foodItem.warningPeriod = temporaryFoodItem.warningPeriod
    }

    private func triggerConfetti() {
        confettiCounter += 1
    }
}
