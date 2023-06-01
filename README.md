# Voice Assistant Application in Flutter

This is a Voice Assistant application developed in Flutter. The application allows users to interact with the assistant using voice commands and receive responses in the form of text or images.

## Features

- User-friendly UI with animations.
- Integration of ChatGPT and DALL-E APIs for testing purposes.
- Voice-to-text conversion for recognizing user commands.
- Ability to create and display text or image responses.

## Screenshots

Here are some screenshots of the application:

![Screenshot 1](Preview.PNG)

## How to Run the Code

To run the code locally, follow these steps:

1. Make sure you have Flutter installed on your system. If not, you can find the installation instructions in the official [Flutter documentation](https://flutter.dev/docs/get-started/install).

2. Clone this repository to your local machine using the following command:

```
git clone https://github.com/your-username/your-repository.git
```
3. Open the project in your preferred code editor.

4. Install the required dependencies by running the following command in the project directory:
```
flutter pub get
```
5. Obtain the necessary API credentials for ChatGPT and DALL-E. If you don't have them yet, you can sign up for the respective services and follow the API documentation to obtain the required credentials.

6. Add the API credentials to the project by creating a new file named `secrets.dart` in the `lib` directory. In this file, define the API credentials as constants:

```dart
// secrets.dart

const String ApiKey = 'YOUR_CHATGPT_API_KEY';
```
7. Once the API credentials are added, you can run the application on a simulator or a physical device by executing the following command:
```
flutter run
```
## Limitations and Future Improvements
- The current implementation of the application uses free versions of the ChatGPT and DALL-E APIs, which have limited responses. To fully launch the application, it would require upgrading to a paid API plan or implementing alternative solutions.
- The voice recognition and conversion process can be further improved to enhance accuracy and speed.
- Additional UI enhancements, such as theme customization and more animations, could be implemented to improve the overall user experience.
