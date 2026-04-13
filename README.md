# Secure Notes

Secure Notes is a high-security Flutter application designed for users who need a private space to store sensitive information. By combining local data persistence with biometric authentication, the app ensures that notes remain private even if the device is unlocked.

## Key Features

- **Biometric Security:** Access is restricted via fingerprint or facial recognition using the local_auth package.

- **Local Persistence:** Notes are stored in a robust SQLite database, ensuring data remains on the device.

- **Intuitive UX:** Supports drag-and-drop reordering of notes and swipe-to-delete functionality.

- **Multilingual Support:** Fully localized for English and French users.

- **Form Validation:** Prevents empty entries with real-time input checking.

## Project Structure

```
lib/
├── l10n/                 # Localization files (App translations)
├── models/               # Data models (Note class)
├── services/             # Logic (Database & Biometric services)
├── screens/              # UI Screens (Home, Add, Edit, Auth)
└── main.dart             # Application entry point
```

## Getting Started

### Installation
1. Clone the repository:
```
git clone https://learn.zone01oujda.ma/git/hlamrani/secure-notes.git
cd secure_notes
```

2. Install dependencies:
```
flutter pub get
```

3. Generate localization files:
```
flutter gen-l10n
```

4. Run the application:
```
flutter run
```

## Collaborators

[Mustapha Boutoub](https://learn.zone01oujda.ma/git/muboutoub)           
[Hasnae Lamrani](https://learn.zone01oujda.ma/git/hlamrani)            
