## Journito:
Organize your tasks and capture your thoughts effortlessly with our AI-powered journaling and task management app. Boost productivity with personalized experience suggestions, easy task tracking, and seamless journaling. Log your daily experiences and thoughts while staying inspired with smart prompts



## Table of Contents
Table of Contents:
- [Description](#description)
- [Installation](#installation)
- [Usage](#usage)
- [Dependencies](#dependencies)
- [Architecture](#architecture)
- [Screenshots](#screenshots)


## Description

**Journito** is a comprehensive app designed to help you live a more fulfilling life. It combines the power of journaling with AI-driven task management and personalized experiences. 

**Key Features:**

* **AI-Powered Experiences:** Discover new and exciting activities tailored to your interests through AI-generated suggestions. Learn more about these experiences with detailed descriptions and helpful information.
* **Task Management:** Stay organized and productive with a user-friendly task management system. Create, schedule, and track your daily tasks to achieve your goals.
* **Journaling:** Reflect on your thoughts, experiences, and emotions with a dedicated journaling feature. Attach photos to capture memories and revisit past entries.
* **Motivational Calendar:** Track your journaling streaks and visualize your progress over time. The calendar also allows you to schedule future tasks and easily review past entries.
* **AI Chat:** Explore new ideas, brainstorm solutions, and get inspiration through an integrated AI chat interface.

**Benefits:**

* **Increased Motivation:** Stay inspired and motivated with personalized experiences and a focus on personal growth.
* **Improved Productivity:** Stay on top of your daily tasks and achieve your goals more effectively.
* **Enhanced Self-Reflection:** Gain deeper insights into your thoughts, feelings, and experiences through regular journaling.
* **Reduced Stress:** Find balance and reduce stress by prioritizing tasks and exploring new activities.
* **Personal Growth:** Discover new passions and interests while building a fulfilling and meaningful life.

**In essence, Journito is a holistic app that empowers you to live a more active, mindful, and fulfilling life by combining the power of AI, personalized experiences, and effective task management.**



## Installation 
Follow the steps below to set up and run Journito on your local machine. This guide assumes you have basic knowledge of software installation and system dependencies.

### Option 1: Direct Installation (Recommended for Users)
To install Journito directly on your Android device:

Prerequisites:
* Android device running Android 5.0 (API level 21) or higher
* At least 22 MB of free storage space
* Permission to install apps from unknown sources

Installation Steps:
1. Download the Journito APK file (21.4 MB) to your Android device
2. Open your device's Settings > Security
3. Enable "Install from Unknown Sources" or "Install Unknown Apps"
4. Find the downloaded APK file in your Downloads folder
5. Tap the APK file and select "Install"
6. Once installation is complete, tap "Open" to launch Journito

### Option 2: Building from Source (For Developers)
Prerequisites
Before installing, ensure you have the following software installed on your machine:

* Flutter SDK: Flutter is the framework used to build the app.
* Android Studio: An IDE used to run the app’s simulation.
* Dart SDK: Dart is the programming language used in Flutter apps.
* Git: For cloning the repository.

After installing Flutter, make sure it's added to your system’s PATH variable. To check if Flutter is correctly installed, run this command:
```bash
flutter doctor
```
**Steps to Install**
* Clone the Repository
First, clone the Journito repository to your local machine using Git:
```bash
git clone https://github.com/mariantaflou/journito.git
```

**Navigate to the Project Directory**
* Change your directory to the project folder:
```bash
cd journito
```
**Install Dependencies**
* Install the required dependencies using Flutter:
```bash
flutter pub get
```

**Open the Project in Android Studio**
* Open Android Studio, then click on "Open" and select the Journito project folder.

**Run the App**

After opening the project, you can run the app on an Android emulator or connected physical device:
* Click the green play button in Android Studio, or
* Use the command line to run the app:
```bash
flutter run
```

**Access the App**

Once the app is running, you can interact with it and test its features. Since Journito is a demo app, you can log in using the default username and password credentials.


## Usage   
Journito is currently in its demo phase, offering a glimpse of its exciting features. Follow these steps to explore the app:

**Getting Started**
Log in using the following credentials:<br>
* Username: **user**
* Password: **password**

**How to use Journaling**
* Tap on **How was your day** to capture your daily thoughts.
* Attach button gives you the opportunity to add photos in order to create memorable visual logs.
* You can also add your thoughts of a new or previous day by simply tapping on a date of the callendar.


**How to use Task Management**
* On the main or journaling screen by tapping to **My tasks** you can see a preview of all your taks.
* Tapping on **(+)** button you can add a task allowing you to set title, date, location, notes.
* Tap on **save** button and your task is ready. So simple!!!

**How to use AI Chat**
* Every screen contains AI chat button to interact effortlessly.
* Tap it and AI chat will give you ideas and help you with day to day tasks.

**How to use Experiences**
* By tapping on **Find experiencies** you can see personalized experiencies recommended by AI.
* All the experiencies include detailed descriptions you can read and follow.

**How to use Motivational Calendar**
* Motivational calendar can be accessed through main and journaling screen by tapping on the date.
* When accessing to it you have options like (add a log ,new task ,find experiences).
* You can see on which dates you have added logs and when you have uppcomming or past tasks.
* See how many logs you have made and make sure not to lose your streaks!
* Choose a date and add a log or a task. Thats it!!


With Journito, transforming your daily routines into meaningful and fulfilling
experiences has never been easier. Start exploring today! 😊



## Dependencies
The project uses the following packages:
* Flutter SDK: ^3.5.4
* shared_preferences: ^2.0.18 (local data persistence)
* http: ^1.1.0 (HTTP client for API requests)
* cupertino_icons: ^1.0.8 (iOS icons)
* table_calendar: ^3.1.3 (calendar integration)
* image_picker: ^1.1.2 (photo picker)
* flutter_dotenv: ^5.1.0 (environment variables management)
* flutter_launcher_icons: ^0.13.1 (app icon configuration)

Development dependencies:
* flutter_test (testing framework)
* flutter_lints: ^4.0.0 (code analysis and style guide)



## Architecture
* The architecture of Journito is designed to ensure scalability, flexibility, and a seamless user experience. The app combines a user-friendly front-end, robust back-end, and AI-driven features to create a comprehensive platform for journaling, task management, and personal growth. This modular design allows easy maintenance and future expansion.

* The design of the application is strongly influenced by established design patterns, which ensure a consistent, intuitive user experience and high-quality code structure. These design patterns dictate how the user interface elements are laid out and how components interact with each other, contributing to the overall architectural integrity of the app.

* To explore the visual representation of these patterns, including layouts, component designs, and interaction flows, refer to the complete design in the Figma file:https://www.figma.com/design/0uJwM5Snv9WTdAGLB65ngM/HCI-2024?node-id=23-68&t=SxadUrtq1NwYEEvf-1




## Screenshots 
* Here you can see all the basic screens our app contains.
 ![image alt](https://github.com/mariantaflou/journito/blob/a86553637b1a53bd81e1c6996b809d1cd79fbc15/Screenshot%202025-01-08%201.jpg)
 ![image alt](https://github.com/mariantaflou/journito/blob/4b1e78c8484e768629f4e6cf1ba03d7c48c3ca7b/Screenshot%202025-01-08%202.jpg)
 ![image alt](https://github.com/mariantaflou/journito/blob/4b1e78c8484e768629f4e6cf1ba03d7c48c3ca7b/Screenshot%202025-01-08%203.jpg)







