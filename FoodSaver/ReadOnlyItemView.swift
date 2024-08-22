import SwiftUI

struct ReadOnlyItemView: View {
    let foodItem: FoodItem

    var body: some View {
        ScrollView {
            VStack {
                Text("Food Item Details")
                    .font(.largeTitle)
                    .padding()

                HStack {
                    Text("Item Name:")
                    Spacer()
                    Text(foodItem.name)
                }
                .padding()

                if let imageData = foodItem.picture, let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .makeFoodViewPhotoBox()
                        .padding()
                } else {
                    Image(systemName: "camera.fill")
                        .makeFoodViewPhotoBox()
                        .padding()
                }

                HStack {
                    Text("Best Before:")
                    Spacer()
                    Text("\(foodItem.bestBeforeDate, formatter: dateFormatter)")
                }
                .padding()

                HStack {
                    Text("Category:")
                    Spacer()
                    Text(foodItem.category)
                }
                .padding()

                HStack {
                    Text("Location:")
                    Spacer()
                    Text(foodItem.location)
                }
                .padding()

                Spacer()
            }
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()
