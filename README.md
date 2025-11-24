<h1 align="center">Tadamon App</h1>
<p align="center">
  <img src="https://socialify.git.ci/MostafaSensei106/Tadamon/image?custom_language=Flutter&font=KoHo&language=1&logo=https%3A%2F%2Favatars.githubusercontent.com%2Fu%2F138288138%3Fv%3D4&name=1&owner=1&pattern=Floating+Cogs&theme=Light" alt="Tadamon App Banner">
</p>

<p align="center">
  <strong>An innovative Flutter application dedicated to supporting the Palestinian cause.</strong><br>
  Built with Flutter, empowering users with tools for product scanning, local data management, and accessing vital information to make conscious consumer choices.
</p>

<p align="center">
  <a href="#-motivation">Motivation</a> •
  <a href="#-about">About</a> •
  <a href="#-features">Features</a> •
  <a href="#-architecture">Architecture</a> •
  <a href="#-technologies">Technologies</a> •
  <a href="#-getting-started">Getting Started</a> •
  <a href="#-roadmap">Roadmap</a> •
  <a href="#-contributing">Contributing</a> •
  <a href="#-license">License</a>
</p>

---

## 🎯 Motivation

In a world where consumer choices have a global impact, the **Tadamon App** (Tadamon means "Solidarity" in Arabic) was created to empower individuals who wish to support the Palestinian cause through ethical consumption. The app provides a transparent and easy-to-use tool to identify products and understand their origins, helping users make informed decisions that align with their values.

Our goal is to foster a community of conscious consumers and provide a reliable resource for those who want to stand in solidarity with Palestine.

---

## 📖 About

**Tadamon App** is a comprehensive Flutter application designed for Android. It serves as a digital assistant for ethical shopping, offering robust product scanning capabilities, offline data access, and seamless cloud synchronization.

The app's core mission is to provide users with the information they need to support their chosen causes. With a clean, intuitive interface and a rich feature set, Tadamon is more than just a utility—it's a tool for making a difference.

---

## ✨ Features

### Core Functionality

- **Barcode Scanning**: Utilizes Google ML Kit for fast and accurate barcode scanning to instantly retrieve product information.
- **Offline First**: Powered by a local Objectbox database, ensuring the app is fully functional even without an internet connection.
- **Cloud Sync**: Seamlessly synchronizes the local database with Firebase Firestore to keep product information up-to-date.
- **PDF Export**: Generate and export detailed reports of scanned products in PDF format for personal records or sharing.
- **User-driven Reporting**: An integrated system for users to report new products or suggest corrections, helping to keep the database accurate and community-driven.
- **Dynamic Theming**: A beautiful and responsive UI with full support for light and dark modes, as well as following the system theme.
- **Localization**: Full support for multiple languages (starting with Arabic) to cater to a global user base.

---

## 🏗️ Architecture

The app is built using a **feature-driven architecture**, promoting a clean separation of concerns and scalability.

- **BLoC Pattern**: State management is handled predictably and efficiently using the BLoC (Business Logic Component) pattern.
- **Repository Pattern**: Abstracts data sources (local database and cloud services), making the app more modular and testable.
- **Dependency Injection**: Core services like database access are provided throughout the app, ensuring loose coupling and maintainability.

### Project Structure

```
lib/
├── core/               # Shared components: routing, theming, widgets, services
├── features/           # Individual feature modules (e.g., product_scanner, home_page)
├── generated/          # Auto-generated files for localization (l10n)
├── l10n/               # Localization files
├── main.dart           # Main application entry point
└── objectbox.g.dart    # Objectbox auto-generated binding files
```

---

## 🛠️ Technologies

This project leverages a modern and robust tech stack for high-quality mobile development:

| Technology                           | Description                                                                             |
| ------------------------------------ | --------------------------------------------------------------------------------------- |
| 🐦 **Flutter & Dart**                | The core framework and language for building beautiful, natively compiled applications. |
| 🗃️ **Objectbox**                     | A high-performance NoSQL database for local, offline-first data storage.                |
| 🔥 **Firebase Firestore**            | A flexible, scalable NoSQL cloud database for data synchronization.                     |
| 🧱 **flutter_bloc**                  | A predictable state management library that helps implement the BLoC pattern.           |
| 📄 **pdf & open_file**               | Libraries for creating, exporting, and opening PDF files.                               |
| 📸 **google_mlkit_barcode_scanning** | For fast and reliable barcode scanning via Google's ML Kit.                             |
| 🌐 **dio & connectivity_plus**       | For handling network requests and monitoring network state.                             |
| 🎨 **flutter_screenutil**            | For creating a responsive UI that adapts to different screen sizes.                     |

---

## 🚀 Getting Started

You can get the Tadamon App up and running in two ways: by downloading a pre-built release or by building it from the source code.

### Option 1: Download from GitHub Releases

For most users, the easiest way to install the app is by downloading the latest APK from the GitHub Releases page.

1.  Go to the **[Releases](https://github.com/MostafaSensei106/Tadamon/releases)** page of this repository.
2.  Under the latest release, find the `app-release.apk` file in the **Assets** section.
3.  Download the APK file to your Android device and install it.
    _You may need to enable "Install from unknown sources" in your device's settings._

### Option 2: Build from Source

If you are a developer and want to build the app from the source code, follow these steps.

#### Prerequisites

- Flutter SDK (version 3.10.1 or higher)
- Android Studio or VS Code with the Flutter extension.

#### Installation

1.  Clone the repository:
    ```bash
    git clone https://github.com/MostafaSensei106/Tadamon.git
    ```
2.  Navigate to the project directory:
    ```bash
    cd Tadamon
    ```
3.  Install dependencies:
    ```bash
    flutter pub get
    ```
4.  Run the code generator for Objectbox and other dependencies:
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```
5.  Run the app on your connected Android device or emulator:
    ```bash
    flutter run
    ```

## 🖼️ Screenshots

_Coming Soon! This section will be updated with screenshots of the app's main features._

| Home Screen    | Scanning       |
| -------------- | -------------- |
| _(screenshot)_ | _(screenshot)_ |
| **Log Page**   | **App Drawer** |
| _(screenshot)_ | _(screenshot)_ |

---

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1.  Fork the Project
2.  Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the Branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request

Please read our (soon-to-be-added) **Contributing Guidelines** for more details.

---

## 📜 License

Distributed under the **GPL-3.0 License**. See the `LICENSE` file for more information.

---

<p align="center">
  Made with ❤️ by <a href="https://github.com/MostafaSensei106">MostafaSensei106</a>
</p>
