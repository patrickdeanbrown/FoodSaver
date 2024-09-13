import SwiftUI

struct BestBeforeDatePicker: View {
    @Binding var bestBeforeDate: Date

    var body: some View {
        VStack(alignment: .leading) {
            Text("Best Before Date")
                .font(Theme.headlineFont)
                .foregroundColor(Theme.secondaryColor)
            DatePicker("Select a Date", selection: $bestBeforeDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding(.vertical, 5)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(8)
        }
        .padding(.horizontal)
    }
}
