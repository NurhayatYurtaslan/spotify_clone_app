# Spotify Clone App


  This Spotify clone app is designed following the BLoC architecture and adheres to Clean Architecture and the MVVM (Model-View-ViewModel) pattern. 

  **Key Features:**
  1. **BLoC Architecture**: 
     The application leverages the BLoC (Business Logic Component) pattern for state management, ensuring separation of concerns and making the app scalable and testable. BLoC ensures that business logic is entirely decoupled from the UI, allowing for better testability and flexibility.
  
  2. **Clean Architecture**: 
     The project structure follows Clean Architecture principles, dividing the app into layers such as `Domain`, `Data`, and `Presentation`. Each layer is independent, making the codebase maintainable and easy to extend. The `Domain` layer contains business logic, `Data` handles repository implementations, and `Presentation` is managed via BLoC.

  3. **MVVM (Model-View-ViewModel)**: 
     The UI layer follows the MVVM pattern, where the `ViewModel` (in this case, BLoC) handles the interaction between the UI and the business logic. Views remain free of logic, and all state changes are managed by the BLoC.

  4. **Dynamic Theme Control**: 
     The app supports dynamic theme switching between dark and light modes. This is handled via a BLoC that monitors the theme state and allows the user to switch themes across the entire application.


## Screenshots
Splash Page (Light)                | Splash Page (Dark)         |   Intro Page (Light)        |   Intro Page (Dark)    
:-------------------------:|:-------------------------:|:-------------------------: |:-------------------------:
![](https://github.com/NurhayatYurtaslan/spotify_clone_app/blob/main/SS/Splash_Light.png?raw=true) |![](https://github.com/NurhayatYurtaslan/spotify_clone_app/blob/main/SS/Splash_Dark.png?raw=true) | ![](https://github.com/NurhayatYurtaslan/spotify_clone_app/blob/main/SS/Intro_Light.png?raw=true) |![](https://github.com/NurhayatYurtaslan/spotify_clone_app/blob/main/SS/Intro_Dark.png?raw=true) | ![]

Choose Mode (Light)                | Choose Mode (Dark)         |   Signin or Signup Page (Light)        |   Signin or Signup Page (Dark)    
:-------------------------:|:-------------------------:|:-------------------------: |:-------------------------:
![](https://github.com/NurhayatYurtaslan/spotify_clone_app/blob/main/SS/Choose_Mode_Light.png?raw=true) |![](https://github.com/NurhayatYurtaslan/spotify_clone_app/blob/main/SS/Choose_Mode_Dark.png?raw=true) | ![](https://github.com/NurhayatYurtaslan/spotify_clone_app/blob/main/SS/SigninOrSignup_Light.png?raw=true) |![](https://github.com/NurhayatYurtaslan/spotify_clone_app/blob/main/SS/SigninOrSignup_Dark.png?raw=true) | ![]

Sign In (Light)                | Sign In (Dark)         |   Sign Up (Light)        |   Sign Up (Dark)    
:-------------------------:|:-------------------------:|:-------------------------: |:-------------------------:
![](https://github.com/NurhayatYurtaslan/spotify_clone_app/blob/main/SS/Signin_Light.png?raw=true) |![](https://github.com/NurhayatYurtaslan/spotify_clone_app/blob/main/SS/Signin_Dark.png?raw=true) | ![](https://github.com/NurhayatYurtaslan/spotify_clone_app/blob/main/SS/Register_Light.png?raw=true) |![](https://github.com/NurhayatYurtaslan/spotify_clone_app/blob/main/SS/Register_Dark.png?raw=true) | ![]

## Design Links:
  - [Dark Theme Design](https://www.figma.com/community/file/1172466818809176172)
  - [Light Theme Design](https://www.figma.com/community/file/1166665330965959412/spotify-redesign-free-ui-kit-light)

## Spotify Clone App - Development Process

 - ✅ Introduction
- Overview of the project, explaining the structure and key features.

 - ✅ Design
- Understanding the design choices and how the overall layout is structured.

 - ✅ Project Structure
- Explanation of how the project is organized following Clean Architecture, BLoC, and MVVM.

 - ✅ Theme of the Application
- Implementing dynamic theme switching (Light/Dark modes).

 - ✅ Assets / Fonts
- Adding and managing assets and custom fonts for the project.

 - ✅ Splash Page
- Creating the splash screen that appears when the app is launched.

 - ✅ Get Started Page
- Implementing the "Get Started" page that introduces users to the app.

 - ✅ Choose Light-Dark Mode Page
- Building the page where users can choose between light and dark themes.

 - ✅ Logic of Light-Dark Mode
- Managing the logic for toggling between light and dark modes using BLoC.

 - ✅ Sign In or Sign Up Page
- Designing the page where users can either sign in or sign up.

 - ✅ Sign Up Page
- Creating the sign-up page, handling form validation, and user input.

 - ✅ Sign In Page
- Building the sign-in page for user authentication.

 - [ ] Firebase Setup
- Setting up Firebase for authentication, Firestore, and storage.

 - ✅ Logic of Authentication
- Handling user authentication using Firebase.

 - [ ] Service Locator
- Implementing the service locator pattern for dependency injection using `get_it`.

 - [ ] UseCases Setup - Calling Signin/Signup UseCases
- Structuring the use cases for signing in and signing up, integrating them with the app's business logic.

 - [ ] Upload Songs to FireStorage
- Enabling users to upload songs to Firebase FireStorage.

 - [ ] Cloud Firestore Collections
- Managing Firestore collections for storing song and user data.

 - [ ] Adding Information of User to Firestore Collection
- Storing user information in Firestore upon sign-up.

 - [ ] Home Page - Fetching Songs - Displaying Songs Using BLoC
- Fetching and displaying songs on the home page using BLoC for state management.

 - [ ] Song Player Page - Using BLoC to Manage State of Playing Song
- Implementing the song player page with BLoC to handle the playback state.

 - [ ] Logic of Favorite Songs
- Adding logic to manage favorite songs (adding/removing from the list).

 - [ ] User Profile Page - Display User Info - Display Favorite Songs - Remove Favorite Song
- Creating the user profile page, displaying user information, favorite songs, and handling the removal of favorites.


## Project Features

- **Clean Architecture Layers**: Implemented to maintain separation of concerns and scalability.
- **BLoC**: Used for state management, ensuring a clear separation between UI and business logic.

## Dependencies

| Dependencies          | Version       | Description                                                              |
|-----------------------|---------------|--------------------------------------------------------------------------|
| **flutter**           | ^3.5.1        | Flutter SDK, the main framework                                           |
| **cupertino_icons**   | ^1.0.8        | iOS-style icons                                                          |
| **flutter_svg**       | ^2.0.10+1     | Render SVG files                                                         |
| **flutter_bloc**      | ^8.1.6        | State management with BLoC (Business Logic Component)                    |
| **hydrated_bloc**     | ^9.1.5        | Persist and restore BLoC states locally                                  |
| **equatable**         | ^2.0.5        | Simplify object comparison                                               |
| **firebase_core**     | ^3.5.0        | Initialize Firebase in a Flutter app                                     |
| **firebase_auth**     | ^5.3.0        | User authentication using Firebase                                       |
| **get_it**            | ^8.0.0        | Dependency Injection for managing app-wide instances                     |
| **dartz**             | ^0.10.1       | Functional programming utilities (e.g., Option, Either)                  |
| **just_audio**        | ^0.9.40       | Play audio files                                                         |
| **flutter_gen**       | ^5.7.0        | Automatically generate asset code for Flutter projects                   |
| **auto_route**        | ^9.2.2        | Automatic route generation and navigation                                |
| **flavor**            | ^2.0.0        | Configure different environments (e.g., testing, production)             |
| **path_provider**     | ^2.1.4        | Access file paths in the device                                          |

## Dependencies

| **Dev Dependencies**  | Version       | Description                                                              |
|-----------------------|---------------|--------------------------------------------------------------------------|
| **flutter_test**       | sdk: flutter  | Flutter's testing framework                                              |
| **build_runner**       | latest        | Code generation and build-time utilities                                 |
| **auto_route_generator**| ^9.0.0       | Code generation for AutoRoute                                            |
| **flutter_gen_runner** | latest        | Code generation for FlutterGen                                           |
| **flutter_lints**      | ^4.0.0        | Lint rules to ensure code quality in Flutter projects                    |
