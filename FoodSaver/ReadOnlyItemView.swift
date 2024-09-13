// ReadOnlyItemView.swift
import SwiftUI

struct ReadOnlyItemView: View {
    let foodItem: FoodItem

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Food Item Details")
                    .font(Theme.titleFont)
                    .foregroundColor(Theme.primaryColor)
                    .padding(.top)
                
                Group {
                    HStack {
                        Text("Item Name:")
                            .font(Theme.headlineFont)
                            .foregroundColor(Theme.secondaryColor)
                        Spacer()
                        Text(foodItem.name)
                            .font(Theme.bodyFont)
                    }
                    
                    if let imageData = foodItem.picture, let image = UIImage(data: imageData) {
                        Image(uiImage: image)
                            .makeFoodViewPhotoBox()
                    } else {
                        Image(systemName: "camera.fill")
                            .makeFoodViewPhotoBox()
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Text("Best Before:")
                            .font(Theme.headlineFont)
                            .foregroundColor(Theme.secondaryColor)
                        Spacer()
                        Text("\(foodItem.bestBeforeDate, formatter: dateFormatter)")
                            .font(Theme.bodyFont)
                    }
                    
                    HStack {
                        Text("Category:")
                            .font(Theme.headlineFont)
                            .foregroundColor(Theme.secondaryColor)
                        Spacer()
                        Text(foodItem.category)
                            .font(Theme.bodyFont)
                    }
                    
                    HStack {
                        Text("Location:")
                            .font(Theme.headlineFont)
                            .foregroundColor(Theme.secondaryColor)
                        Spacer()
                        Text(foodItem.location)
                            .font(Theme.bodyFont)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .animation(.easeInOut, value: foodItem)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()
