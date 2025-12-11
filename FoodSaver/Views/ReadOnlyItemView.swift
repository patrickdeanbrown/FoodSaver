import SwiftUI

struct ReadOnlyItemView: View {
    let foodItem: FoodItem

    var body: some View {
        ZStack {
            Theme.background
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
                    Text("Food Item Details")
                        .font(Theme.titleFont)
                        .foregroundColor(Theme.textPrimary)
                        .padding(.top, Theme.Spacing.md)

                    VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                        infoRow(title: "Item Name", value: foodItem.name)

                        if let imageData = foodItem.picture, let image = UIImage(data: imageData) {
                            Image(uiImage: image)
                                .makeFoodViewPhotoBox()
                        } else {
                            Image(systemName: "camera.fill")
                                .makeFoodViewPhotoBox()
                                .foregroundColor(Theme.textTertiary)
                        }

                        infoRow(title: "Best Before", value: DateFormatter.mediumStyle.string(from: foodItem.bestBeforeDate))
                        infoRow(title: "Category", value: foodItem.category)
                        infoRow(title: "Location", value: foodItem.location)
                    }
                    .padding(Theme.Spacing.md)
                    .background(Theme.surface)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Theme.border, lineWidth: 1)
                    )
                    .cornerRadius(16)
                }
                .padding(.horizontal, Theme.Spacing.md)
                .padding(.bottom, Theme.Spacing.lg)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    private func infoRow(title: String, value: String) -> some View {
        HStack(alignment: .top) {
            Text("\(title):")
                .font(Theme.headlineFont)
                .foregroundColor(Theme.textSecondary)
            Spacer()
            Text(value)
                .font(Theme.bodyFont)
                .foregroundColor(Theme.textPrimary)
                .multilineTextAlignment(.trailing)
        }
    }
}

//struct ReadOnlyItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReadOnlyItemView(foodItem: FoodItem(name: "Apple", bestBeforeDate: Date(), category: "Fresh Produce", location: "Fridge", warningPeriod: 3))
//    }
//}
