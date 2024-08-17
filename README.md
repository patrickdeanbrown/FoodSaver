# 🥫 Food Saver

Welcome to **Food Saver**! 🍕🍰🥬 This iOS app for keeping track of food items in your household, helping you avoid waste and stay organized.

Food Saver is more than an app—it’s my learning experiment in embracing Swift and Apple frameworks using an LLM-oriented workflow. I began by crafting a [*product specification document*](./product_specifications.md), which outlines the high-level steps to build **Food Saver**. With this blueprint, I worked with ChatGPT-4o to code the app in Xcode.

The product specification is a living document designed to maintain the app’s core features, design, and structure. It’s written in plain text to ensure compatibility with current and future LLMs, making the app as rewritable and future-proof as possible. The goal is to reduce legacy tech debt, enabling Food Saver to adapt to new platforms and technologies with minimal overhead. As **Food Saver** grows in complexity, I'm interested in finding out whether providing an LLM the "why" behind code improves its reliability in software development.

## 📱 App Overview

### 🌟 Key Features

- **Track Inventory:** Easily keep track of all your food items and their expiration dates.
- **Smart Status Indicators:** Quickly see the freshness of your items with intuitive status emojis (🔴🟡🟢).
- **Search & Filter:** Find exactly what you're looking for using advanced search and filter options.
- **Easy Management:** Add, modify, or delete items with a user-friendly interface.

## 🛠️ Technology Stack

- **Language:** Swift 
- **UI Framework:** SwiftUI
- **Data Management:** SwiftData 
- **Design Pattern:** MV (Model-View)
- **APIs:** Apple’s Photos & Camera Frameworks

## 🗂️ Project Structure

## 🗂️ Project Structure

| File/Directory                | Description                                           |
|-------------------------------|-------------------------------------------------------|
| **FoodSaverApp.swift**         | Entry point for the app, manages main navigation      |
| **MainView.swift**             | Main interface of the app, displaying the list of food items |
| **AddModifyItemView.swift**    | Interface for adding or modifying food items          |
| **ReadOnlyItemView.swift**     | Displays detailed, read-only view of food items       |
| **FoodItem.swift**             | SwiftData model for food items                        |
| **FoodItemTemp.swift**         | Temporary data model for managing unsaved changes     |
| **FoodItemRow.swift**          | UI component for listing food items in the main view  |
| **FoodViewPhotoBox.swift**     | UI component for displaying food images with rounded borders |
| **SearchBar.swift**            | Custom search bar with search category picker         |
| **ImagePicker.swift**          | Custom image picker for capturing food item images    |
| **SplashScreenView.swift**     | Initial splash screen with app logo                   |


## 🤝 Contributing

If you have ideas, find bugs, or just want to collaborate, feel free to open an issue or submit a pull request! Whether you’re here to improve Food Saver or to explore the code and learn more about LLM-assisted development, your contributions are always welcome.
