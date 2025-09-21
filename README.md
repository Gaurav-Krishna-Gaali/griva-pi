# Griva PI

A Flutter application for medical colposcopy procedures and patient management.

## Description

Griva PI is a comprehensive medical application designed to assist healthcare professionals with colposcopy examinations, patient data management, and clinical reporting. The app provides tools for connecting colposcopes, managing patient records, and generating medical reports.

## Features

- **Patient Management**: Create and manage patient records
- **Colposcopy Integration**: Connect and control colposcope devices
- **Clinical Data Forms**: Comprehensive medical data collection
- **Gallery Management**: Store and organize medical images
- **Report Generation**: Generate PDF medical reports
- **User Authentication**: Secure login and user profile management

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Android Studio / VS Code
- Android SDK for Android builds
- iOS development tools (for iOS builds)

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd griva_pi
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the application:
```bash
flutter run
```

## Building and Deployment

### Android APK Build

To build a release APK for Android:

```bash
# Initialize Shorebird (first time only)
shorebird init

# Build release APK
shorebird release android --artifact apk
```

### Creating Patches

To create a patch for an existing release:

```bash
shorebird patch --platforms=android --release-version=1.0.0+1
```

## Project Structure

```
lib/
├── main.dart                 # Application entry point
├── home_page.dart           # Main dashboard
├── login_page.dart          # Authentication screen
├── screens/                 # Application screens
│   ├── patient_form_screen.dart
│   ├── patient_list_screen.dart
│   ├── clinical_data_form_screen.dart
│   └── user_profile_screen.dart
├── services/                # Business logic services
│   ├── patient_service.dart
│   ├── user_service.dart
│   ├── medical_report_service.dart
│   └── pdf_service.dart
└── models/                  # Data models
```

## Development

This project uses Flutter framework with the following key dependencies:
- State management
- PDF generation
- Image handling
- Network connectivity
- Local storage

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

[Add your license information here]

## Support

For support and questions, please contact [your contact information].

