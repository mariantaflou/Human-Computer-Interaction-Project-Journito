## Journito:
A Flutter-based application designed for task management and journaling<br>
with modern UI and persistence features.


## Table of Contents
Table of Contents:
- [Description](#description)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Dependencies](#dependencies)
- [Architecture](#architecture)
- [Screenshots](#screenshots)
- [License](#license)


## Description
Journito is a task management and journaling app that helps users stay<br>
organized. With features like login persistence, calendar integration,<br>
AI chat,and photo attachment, Journito is built to enhance productivity.


## Features
•User authentication with persistent login state.<br>
•Calendar view for task management (powered by table_calendar).<br>
•Image attachment with the device's gallery or camera (using image_picker).<br>
•Modern UI design with gradient backgrounds and customizable themes.<br>
•Data persistence using shared_preferences.<br>
•AI chat  to provide accurate and real-time responses. 

## Installation
1.Clone the repository:
Copy code git clone https://github.com/mariantaflou/journito.git
2.Navigate to the project directory:
cd journito
3.Install dependencies:
flutter pub get
4.Run the app:
flutter run


## Usage
1.Launch the app.<br>
2.Log in using <span style="color:blue">username.</span> as username and <span style="color:red">password.</span> as password.<br>
3.Use the calendar to view or create tasks.<br>
4.Attach images to your tasks for better context.<br>
5.Logout or close the app—your data is saved automatically.<br>



## Dependencies
The project uses the following packages:<br>
•Flutter SDK: ^3.5.4<br>
•shared_preferences: ^2.0.18 (local data persistence)<br>
•table_calendar: ^3.1.3 (calendar integration)<br>
•image_picker: ^1.1.2 (photo picker)<br>
•cupertino_icons: ^1.0.8 (iOS icons)<br>



## Architecture
Journito follows a clean architecture pattern:<br>
•UI Layer: Handles visual representation and user interaction.<br>
•Data Layer: Manages persistence with shared_preferences and any future<br> integration with a remote database.<br>
•State Management: Stateless widgets combined with controllers for simplicity.<br>


## Screenshots
Add screenshots of your app's UI (login screen, calendar view, task details, etc.).


## License
This project was created as part of a computer-human interaction assignment <br>and is not licensed for public or commercial use.

## Credits
This project was created collaboratively by:<br>
•[Your Name]: Role or area of focus (e.g., "UI/UX Design and Frontend Development")<br>
•[Second Person's Name]: Role or area of focus (e.g., "Backend Development and Database Management")<br>
•[Third Person's Name]: Role or area of focus (e.g., "Testing and Documentation")



