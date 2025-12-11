import SwiftUI
import SwiftData
import ConfettiSwiftUI

struct AddModifyItemView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @StateObject var viewModel: AddModifyItemViewModel
    @FocusState private var isInputActive: Bool

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

    private var isSaveDisabled: Bool {
        !viewModel.canSave
    }

    // Updated initializer to take a viewModel parameter
    init(viewModel: AddModifyItemViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text(viewModel.isNewItem ? "Add Food Item" : "Modify Food Item")
                    .font(Theme.titleFont)
                    .foregroundColor(Theme.primaryColor)
                    .padding(.top)

                ItemNameField(name: $viewModel.temporaryFoodItem.name, isInputActive: $isInputActive)

                ImagePickerButton(temporaryFoodItem: $viewModel.temporaryFoodItem)
                    .onChange(of: viewModel.temporaryFoodItem.inputImage) { _, _ in
                        viewModel.loadImage()
                    }

                BestBeforeDatePicker(bestBeforeDate: $viewModel.temporaryFoodItem.bestBeforeDate)

                CategoryPicker(category: $viewModel.temporaryFoodItem.category, categories: categories, warningPeriod: $viewModel.temporaryFoodItem.warningPeriod)

                LocationPicker(location: $viewModel.temporaryFoodItem.location, locations: locations)

                Spacer()

                ActionButtons(
                    onCancel: {
                        dismiss()
                    },
                    onSave: {
                        viewModel.saveChanges(context: context)
                        guard !viewModel.showError else { return }

                        if viewModel.isNewItem && !reduceMotion {
                            triggerConfetti()
                        }
                        // Delay dismissal to allow confetti to display
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            dismiss()
                        }
                    }
                )
                .disabled(isSaveDisabled)
                .opacity(isSaveDisabled ? 0.6 : 1)
                .padding(.horizontal)

                if isSaveDisabled {
                    Text("Enter a name, category, and location to save.")
                        .font(.footnote)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .scrollDismissesKeyboard(.interactively)
        .confettiCannon(counter: reduceMotion ? .constant(0) : $confettiCounter, num: Constants.confettiCount, radius: Constants.confettiRadius)
        .alert(isPresented: $viewModel.showError) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    private func triggerConfetti() {
        guard !reduceMotion else { return }
        confettiCounter += 1
    }
}

struct AddModifyItemView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleFoodItem = FoodItem(name: "Apple", bestBeforeDate: Date(), category: "Fresh Produce", location: "Fridge", warningPeriod: 3)
        let viewModel = AddModifyItemViewModel(foodItem: sampleFoodItem)
        AddModifyItemView(viewModel: viewModel)
    }
}
