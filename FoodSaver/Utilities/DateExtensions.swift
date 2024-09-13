import Foundation

extension DateFormatter {
    static let mediumStyle: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
}
