# 📚 Bookly - Your Personal Reading Companion

[![Flutter](https://img.shields.io/badge/Flutter-3.2.3+-02569B?logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.2.3+-0175C2?logo=dart&logoColor=white)](https://dart.dev/)
[![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android-lightgrey)](https://flutter.dev/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

> A modern mobile book management application built with Flutter for iOS and Android. Discover, explore, and manage your favorite books with an intuitive and beautiful user interface.

## ✨ Features

### 👤 User Features
- **🔐 Authentication** - Secure user registration and login system
- **📖 Book Discovery** - Browse books by categories, search, and explore recommendations
- **⭐ Ratings & Reviews** - View top-rated books and user ratings
- **🔍 Advanced Search** - Powerful search functionality to find books quickly
- **📱 Book Details** - Detailed information about each book
- **💬 Chat Support** - Direct communication with admin for support
- **👤 User Profile** - Manage your personal information and preferences
- **⚙️ Settings** - Customize your app experience

### 🛠️ Admin Features
- **📚 Book Management** - Add, edit, and manage books in the library
- **🏷️ Category Management** - Organize books with custom categories
- **💬 Admin Chat** - Communicate with users and provide support
- **📊 Dashboard** - Overview of books and categories

### 🎨 UI/UX Highlights
- **Modern Material Design 3** - Beautiful and intuitive interface
- **Smooth Animations** - Lottie animations for enhanced user experience
- **Responsive Layout** - Optimized for all screen sizes
- **Dark/Light Theme Support** - Comfortable reading experience
- **Image Caching** - Fast loading with cached network images
- **Skeleton Loading** - Smooth loading states with skeleton screens

## 🛠️ Tech Stack

### Core Technologies
- **Flutter** - Cross-platform framework
- **Dart** - Programming language

### State Management
- **Riverpod** - Modern state management solution

### Navigation
- **Auto Route** - Code generation for type-safe navigation

### Networking
- **Dio** - Powerful HTTP client for API calls
- **HTTP** - Additional HTTP utilities

### Storage
- **Shared Preferences** - Local data storage
- **Flutter Secure Storage** - Secure credential storage

### Localization
- **Easy Localization** - Internationalization support

### UI Components
- **Cached Network Image** - Efficient image loading and caching
- **Carousel Slider** - Beautiful book carousels
- **Lottie** - Smooth animations
- **Rating Bar** - User rating interface
- **Skeletonizer** - Loading state animations
- **Persistent Bottom Nav Bar** - Navigation bar

### Development Tools
- **Sentry** - Error tracking and monitoring
- **JSON Serializable** - Code generation for JSON
- **Build Runner** - Code generation tool
- **Flutter Lints** - Code analysis and linting

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:
- **Flutter SDK** (>=3.2.3)
- **Dart SDK** (>=3.2.3)
- **Android Studio** (for Android development)
- **Xcode** (for iOS development - macOS only)
- **Git**

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/bookly_app.git
   cd bookly_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code (for routes, JSON serialization, etc.)**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Configure environment**
   - Update the API base URL in `lib/env.dart` if needed
   - The app currently uses: `http://smartshelf.runasp.net/api/`

5. **Run the app**
   ```bash
   # For Android
   flutter run

   # For iOS
   flutter run

   # For a specific device
   flutter devices
   flutter run -d <device-id>
   ```

### Build for Production

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release
```

## 📁 Project Structure

```
lib/
├── assets/              # Images, animations, and other assets
├── components/          # Reusable UI components
│   ├── default_button.dart
│   ├── default_text_field.dart
│   ├── default_nav_bar.dart
│   └── default_progress_indicator.dart
├── constants/           # App constants and colors
│   ├── app_colors.dart
│   └── constants.dart
├── controller/          # Business logic and state management
│   ├── providers/       # Riverpod providers
│   └── services/        # API services
├── helpers/             # Utility functions and extensions
│   ├── context_extension.dart
│   ├── http_client.dart
│   ├── networking.dart
│   └── scroll_helpers.dart
├── model/               # Data models
│   ├── book_model/
│   ├── categories/
│   ├── chat_model/
│   └── ...
├── router/              # Navigation and routing
│   └── router.dart
├── views/               # UI screens and pages
│   ├── admin_module/    # Admin screens
│   ├── auth/            # Authentication screens
│   ├── home/            # Home screen and widgets
│   ├── book_details/    # Book detail screen
│   ├── search/          # Search screen
│   ├── settings/        # Settings and support
│   └── ...
├── env.dart             # Environment configuration
└── main.dart            # App entry point
```

## 🔌 API Integration

The app integrates with a RESTful API for:
- User authentication and registration
- Book data (categories, details, recommendations)
- Search functionality
- User interactions (ratings, chat)
- Admin operations (book management, categories)

**Base URL:** Configured in `lib/env.dart`

## 🎯 Key Features Implementation

- **State Management**: Uses Riverpod for predictable state management
- **Navigation**: Type-safe navigation with Auto Route code generation
- **Error Handling**: Integrated Sentry for error tracking and monitoring
- **Localization**: Ready for multi-language support with Easy Localization
- **Security**: Secure storage for sensitive data
- **Performance**: Optimized with image caching and efficient state management

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👤 Author

**Abdelwhab Ahmed**

- GitHub: (https://github.com/AbdelwhabAhmed)
- LinkedIn: (https://www.linkedin.com/in/abdelwhab-ahmed-323976262/)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- All the package maintainers who made this project possible
- The open-source community

---

<div align="center">
  
**⭐ If you find this project helpful, please give it a star! ⭐**

Made with ❤️ using Flutter

</div>
