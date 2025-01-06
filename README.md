# Journito:
A Flutter-based application designed for task management and journaling
with modern UI and persistence features.

Table of Contents:
1. Description
2. Features
3. Installation
4. Usage
5. Dependencies
6. Architecture
7. Screenshots
8. License


# Description:
>Journito is a task management and journaling app that helps users stay
organized. With features like login persistence, calendar integration,
and photo attachment, Journito is built to enhance productivity.


# Features:
>User authentication with persistent login state.
>Calendar view for task management (powered by table_calendar).
>Image attachment with the device's gallery or camera (using image_picker).
>Modern UI design with gradient backgrounds and customizable themes.
>Data persistence using shared_preferences.

# Instalation:
1.Clone the repository:
Copy code git clone https://github.com/mariantaflou/journito.git
2.Navigate to the project directory:
cd journito
3.Install dependencies:
flutter pub get
4.Run the app:
flutter run


# Usage:
Launch the app.
Create an account or log in with your credentials.
Use the calendar to view or create tasks.
Attach images to your tasks for better context.
Logout or close the app—your data is saved automatically.



# Dependencies:
The project uses the following packages:
Flutter SDK: ^3.5.4
shared_preferences: ^2.0.18 (local data persistence)
table_calendar: ^3.1.3 (calendar integration)
image_picker: ^1.1.2 (photo picker)
cupertino_icons: ^1.0.8 (iOS icons)



# Architecture:
Journito follows a clean architecture pattern:
UI Layer: Handles visual representation and user interaction.
Data Layer: Manages persistence with shared_preferences and any future integration with a remote database.
State Management: Stateless widgets combined with controllers for simplicity.


# Screenshots:
Add screenshots of your app's UI (login screen, calendar view, task details, etc.).


# License:
This project was created as part of a computer-human interaction assignment and is not licensed for public or commercial use.

# Credits:
This project was created collaboratively by:

[Your Name]: Role or area of focus (e.g., "UI/UX Design and Frontend Development")
[Second Person's Name]: Role or area of focus (e.g., "Backend Development and Database Management")
[Third Person's Name]: Role or area of focus (e.g., "Testing and Documentation")



