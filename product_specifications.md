# Food Saver App Product Specifications

## Purpose

The Food Saver app is an iOS app that allows users to create a private searchable database of foods in their households. It keeps track of the user's current inventory of food and their expiration dates. The user can add new foods, delete foods from their inventory, or change the information associated with a food.

## Data Model

The Food Saver app stores the following information about each food entered by the user:
- Name (String)
- Picture (Image)
- Best Before Date (Date)
- Purchase Date (Date)
- Category (String)
- Location (String)
- Status (Status Type)

Name: A string that is the name of the food.
Picture: An image that represents the food, taken by the user.
Best Before Date: A date that is the best before date of the food.
Category: A string that is the category of the food, e.g. "Produce", "Snacks" or "Dairy".
Location: A string that is the location where the food is, e.g. "Kitchen", "Fridge".
Status: Enum that is the status of the food. It can either be "Expired", "Expiring" or "Fresh". "Expired" is on or after the best before date. "Expiring" is 60% of the way to the best before date. "Fresh" is less than 40% of the way to the best before date. Status will be shown in the app as a red dot emoji ("Expired"), yellow dot emoji ("Expiring") or green dot emoji ("Fresh"). Status is calculated when the application loads, so it is not user editable. It will also be recalculated if the field is updated by the user.

The data is likely going to be lightweight due to households having a finite amount of space for food. The information is also not sensitive, so it can be stored in plain text. The following should be stored in the app as JSON: Name, path to Picture, Best Before Date, Category, Location, Status. The Picture should be stored as an image file in the app in a Pictures folder.

## Programming Pardigms and APIs

The Food Saver app is intended to be an iOS app with a native look an feel. It should feel like an app familiar to iOS users from an interface and asthetics perspective. The app will use Apple's built-in camera and photo library to take pictures of foods.

Core Language: Swift
UI Library: Swift UI
APIs: Apple's Photos Framework, Apple's Camera Framework
Data: SwiftData
Application design pattern: MV

File Structure
 - FoodSaverApp.swift - @main entry point for application
 - FoodViewModel.swift - ViewModel for the main view of the app.
 - MainView.swift - View for the main view of the app.
 - FoodItem.swift - Data model for the app.
 - PersistenceController.swift - PersistenceController for the app.
 - ContentView.swift  - Main view of the app.
 - AddModifyItemsView.swift - View for adding and modifying food items.


## User Interface (UI) Views

### Splash Screen

After the app is started a spash screen showing the app logo appears for 1.5 seconds. The it is removed to show the main view. The "Splash Scree" will show the text "Food Saver" and a picture of emoji foods, peach, ramen, cake, and lettuce, below the text. The text will be large and centered vertically and horizontally.

### Main View

The "Main View" is the starting point of the app's functionality. At the top, it shows the title "Food Saver".

Next it shows a search bar and a search selector. The search bar is a plaintext search bar that will be used to search for food based on the search selector. The search selector will be a dropdown menu that will allow the user to choose what they want to search by. It will have the options "Name", "Category", "Location" and "Status". It will autocomplete based on the typing activity in the search bar. Autocomplete suggestions will be shown by a dropdown menu. For example, if the user enters "pi" into the search bar then the autocomplete menu may show "pizza", "pie" and "pineapple" as suggestions. As text is entered into the search bar it will automatically run the search and update the search results.

Below the search bar are the food item list. The food item list will be a scrollable list of food items that will be displayed in a table view. The food item list will show the name, category, location, and status of each food item. The name will be bold and large. The category and location will be smaller. The status will be on the right hand side of the entry and show a red ("Expired"), yellow ("Expiring"), or green ("Fresh") emoji dot depending on the status of the food item.

Each item in the food item list can be swiped to the left. When swiped to the left, the user will uncover two option, "Modify", and "Delete". The "Modify" option will allow the user to modify the food item on the "Add/Modify Item View". The "Delete" option will delete that specific food item from the database and list.

In the bottom right hand corner is a circular blue button with a white plus sign. This button leads to the "Add/Modify Item View", with a blank entry for a new food item.


### Add/Modify Item View

The top of the view reads "Add/Modify Food Item". The bottom of the view reads "Back". The back button will take you back to the "Main View". Clicking "Back" will not save any changes made in this view. The "Save" button will save all changes made in this view and return to the "Main View".

From top to bottom:
- Item Name (Text Box)
- Photo Box (Tap to be taken to the camera API, displays a picture of the food item or camera emoji if no picture is available. Tap to take a picture and return back to this view.)
- Best Before Date (Date Picker)
- Category (Text box that autocompletes based on prior category entries)
- Location (Text box that autocompletes based on prior location entries)
- Spacer
- Back button (Takes you back to the "Main View") and Save button (Saves all changes made in this view) on the same line


### Camera View
When the "Photo Box" is tapped on the "Add/Modify Item View", a standard iOS camera view will be displayed. Taking a picture and returning to this view will save it as a new image in the app. The old picture will be replaced with the new one.


### User Test Plan

#### 1. **Splash Screen**

**Objective**: Ensure the splash screen displays correctly.

- **Test Case**: Launch the app.
  - **Expected Result**: The splash screen with the "Food Saver" text and emoji foods should appear for 1.5 seconds and then transition to the Main View.
  - **Steps**:
    1. Close the app if it's running.
    2. Launch the app.
    3. Observe the splash screen and transition.

#### 2. **Main View**

**Objective**: Ensure the Main View displays correctly and functionality works as expected.

- **Test Case**: Check the Main View layout.
  - **Expected Result**: The Main View should display the title "Food Saver", a search bar, a search selector, and a list of food items.
  - **Steps**:
    1. Launch the app.
    2. Observe the Main View layout.

- **Test Case**: Search for food items.
  - **Expected Result**: Typing in the search bar should filter food items based on the selected category.
  - **Steps**:
    1. Enter text in the search bar.
    2. Select different search categories.
    3. Observe the filtered results.

- **Test Case**: Swipe to modify or delete a food item.
  - **Expected Result**: Swiping left on a food item should reveal the "Modify" and "Delete" buttons. A full swipe should delete the item.
  - **Steps**:
    1. Swipe left on a food item.
    2. Tap "Modify".
    3. Make changes and save.
    4. Swipe left again and perform a full swipe to delete.

- **Test Case**: Add a new food item.
  - **Expected Result**: Tapping the add button should navigate to the Add/Modify Item View with a blank entry.
  - **Steps**:
    1. Tap the blue button with a white plus sign.
    2. Observe the Add/Modify Item View with blank fields.

#### 3. **Add/Modify Item View**

**Objective**: Ensure the Add/Modify Item View displays correctly and functionality works as expected.

- **Test Case**: Add a new food item.
  - **Expected Result**: All fields should be editable, and the photo box should have a rounded border. Saving should update the Main View.
  - **Steps**:
    1. Enter text in all fields.
    2. Tap the photo box to take a picture.
    3. Set the Best Before Date and Purchase Date.
    4. Save the item.
    5. Return to the Main View and check if the item appears correctly.

- **Test Case**: Modify an existing food item.
  - **Expected Result**: Fields should be pre-filled with the item's data. Making changes and saving should update the Main View.
  - **Steps**:
    1. Swipe left on an existing item and tap "Modify".
    2. Make changes to the fields.
    3. Save the item.
    4. Return to the Main View and check if the changes appear correctly.

#### 4. **Read-Only View**

**Objective**: Ensure the Read-Only View displays correctly and functionality works as expected.

- **Test Case**: View food item details.
  - **Expected Result**: Tapping a food item should navigate to the Read-Only View, displaying all details in a read-only format.
  - **Steps**:
    1. Tap on a food item in the Main View.
    2. Observe the Read-Only View layout and data.

#### 5. **Status Calculation**

**Objective**: Ensure the status calculation works correctly.

- **Test Case**: Verify status dots.
  - **Expected Result**: The status dot should correctly reflect the food item's status based on the Best Before Date.
  - **Steps**:
    1. Add items with varying Best Before Dates.
    2. Observe the status dots (red, yellow, green) in the Main View.
    3. Modify dates to trigger status changes and verify updates.

#### 6. **Portrait Mode Only**

**Objective**: Ensure the app operates in portrait mode only.

- **Test Case**: Rotate the device.
  - **Expected Result**: The app should remain in portrait mode.
  - **Steps**:
    1. Open the app.
    2. Rotate the device to landscape mode.
    3. Observe the app remains in portrait mode.

#### 7. **Keyboard and Scrolling**

**Objective**: Ensure the keyboard does not obstruct fields and the view scrolls correctly.

- **Test Case**: Enter data with the keyboard open.
  - **Expected Result**: The view should scroll to keep the active text field visible.
  - **Steps**:
    1. Tap a text field to open the keyboard.
    2. Enter text and switch between fields.
    3. Observe the scrolling behavior.

#### 8. **Log Messages**

**Objective**: Ensure the app does not produce unexpected log messages.

- **Test Case**: Monitor log messages during usage.
  - **Expected Result**: No unexpected log messages should appear.
  - **Steps**:
    1. Run the app.
    2. Perform various actions (adding, modifying, deleting items).
    3. Check Xcode console for log messages.

### Reporting Results

For each test case, report the following:

- **Test Case**: Launch the app.
- **Result**: Pass
- **Description**: Splash Screen is displayed correctly. MainView displays after 1.5 seconds.
- **Steps to Reproduce**: Detailed steps to reproduce the issue, if applicable.
- **Screenshots/Logs**: 

By conducting these tests, you can identify and fix any functionality issues, ensuring a smooth and reliable user experience for the Food Saver app.
