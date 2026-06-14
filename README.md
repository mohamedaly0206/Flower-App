# 🌸 Flowery App

<p align="center">
  <img <img width="89" height="25" alt="Logo" src="https://github.com/user-attachments/assets/3622f571-a3bb-44c0-b2f1-052446bf8c2e" alt="Exam App Logo" width="140" />
</p>

<p align="center">
  <strong>An enterprise-grade, beautifully designed Flowers & Gifting E-Commerce mobile platform built with Flutter.</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/Architecture-Clean%20%2F%20Feature--First-success?style=for-the-badge" alt="Architecture" />
  <img src="https://img.shields.io/badge/CI%2FCD-GitHub%20Actions-blue?style=for-the-badge&logo=githubactions&logoColor=white" alt="CI/CD" />
</p>

A Flutter e-commerce application for browsing and ordering flowers. The app is built with a feature-first Clean Architecture style and includes authentication, product discovery, cart management, orders, profile management, localization, and API integration with the Elevate Flower backend.
## Screenshots

<p align="center">
  <img src="https://github.com/user-attachments/assets/59067217-0647-4b15-ac76-fa5c2f6b9316" width="22%" height="300"/>
  <img src="https://github.com/user-attachments/assets/73af289f-4ea2-4d9d-b788-32a429cb08d3" width="22%" height="300"/>
  <img src="https://github.com/user-attachments/assets/b46d0051-f756-49c2-b5d0-84fa02f359d6" width="22%" height="300"/>
  <img src="https://github.com/user-attachments/assets/bf1e1672-5885-4c34-aab2-c6f81c5b6e5a" width="22%" height="300"/>
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/14cb2ab6-2349-4c58-baa5-c739d91f8094" width="22%" height="300"/>
  <img src="https://github.com/user-attachments/assets/324ac971-8afe-41d9-92ca-42d4069d7b6b" width="22%" height="300"/>
  <img src="https://github.com/user-attachments/assets/47eb7785-ac51-459e-bda3-e7b9528951c4" width="22%" height="300"/>
  <img src="https://github.com/user-attachments/assets/30c5b4f5-c0e5-41e0-89ea-d092516a0eec" width="22%" height="300"/>
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/c408b48f-a81b-4404-ae3b-d1d9c307167b" width="22%" height="300"/>
  <img src="https://github.com/user-attachments/assets/70610b3f-e122-494a-9a23-adfd8e0a1c0b" width="22%" height="300"/>
</p>

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Code Generation](#code-generation)
- [Localization](#localization)
- [Testing](#testing)
- [API](#api)

## Overview

Flower App is a cross-platform Flutter project that delivers a complete shopping flow for flowers and gifts. It supports guest/authenticated entry, secure token storage, localized English and Arabic UI, product browsing by category and occasion, best sellers, cart actions, orders, and user profile operations.

## Features

- Authentication: login, sign up, logout, change password, and forgot password flow.
- Home sections: categories, occasions, best sellers, and shared product data.
- Product browsing: product cards, product details, category listing, sorting, and search.
- Cart: add items, remove items, update quantity, and view checkout totals.
- Orders: fetch and display user orders.
- Profile: profile data, edit profile, upload profile photo, language selection, and guest handling.
- Localization: English and Arabic support using Flutter generated localizations.
- Secure persistence: token and app preferences stored with `flutter_secure_storage`.
- Network layer: `dio` with Retrofit API clients and JSON serialization.
- State management: `flutter_bloc` Cubits with intent/state separation.
- Dependency injection: `get_it` and `injectable`.
- Tests: unit tests for API data sources, repositories, use cases, and Cubits.

## Tech Stack

- Flutter / Dart
- `flutter_bloc` for state management
- `go_router` for navigation
- `dio` and `retrofit` for networking
- `json_serializable` for model serialization
- `get_it` and `injectable` for dependency injection
- `flutter_secure_storage` for secure local storage
- `flutter_localizations` and ARB files for localization
- `mocktail`, `mockito`, and `bloc_test` for testing

## Architecture

The project follows a feature-first Clean Architecture approach. Most features are split into:

- `presentation`: views, widgets, Cubits, intents, and states.
- `domain`: entities, repository contracts, and use cases.
- `data`: DTOs, repository implementations, and data source contracts.
- `api`: Retrofit API clients and remote data source implementations.

This keeps UI, business rules, data mapping, and network integration separated and easier to test.

## Project Structure

```text
lib/
  config/
    di/                  Dependency injection setup
    dio/                 Dio configuration
    security_storage/    Secure storage abstraction
  core/
    errors/              Exceptions and failures
    localization/        App locale controller
    network/             API interceptor
    router/              GoRouter setup and route paths
    shared_features/     Shared products and home data
    theme/               Colors, text styles, and app theme
    values/              Generated assets, fonts, API constants
    widgets/             Shared UI widgets
  features/
    app_sections/        Main app shell, home, cart, categories, profile
    auth/                Login, sign up, and forgot password
    best_seller/         Best seller listing
    change_password/     Change password flow
    edite_profile/       Edit profile flow
    occasion/            Occasion listing
    orders/              Orders listing
    product_details/     Product details screen
    search/              Product search
  l10n/                  Localization ARB files and generated classes
test/                    Unit and Cubit tests
assets/
  icons/                 SVG assets
  fonts/                 Inter font family
```

## Getting Started

### Prerequisites

- Flutter SDK compatible with Dart `^3.11.0`
- Android Studio or Xcode for mobile builds
- A configured emulator, simulator, or physical device

Check your Flutter setup:

```bash
flutter doctor
```

### Installation

Clone the repository and install dependencies:

```bash
flutter pub get
```

Generate required files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Run the app:

```bash
flutter run
```

Run on a specific platform:

```bash
flutter run -d chrome
flutter run -d android
flutter run -d ios
flutter run -d windows
```

## Code Generation

This project uses generated code for Retrofit clients, JSON models, dependency injection, assets, fonts, and localization.

Run code generation after changing API clients, DTOs, injectable classes, assets, or fonts:

```bash
dart run build_runner build --delete-conflicting-outputs
```

For continuous generation during development:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

## Localization

Localization is configured in `l10n.yaml`.

- ARB source files: `lib/l10n/app_en.arb`, `lib/l10n/app_ar.arb`
- Generated output: `lib/l10n/app_localizations.dart`
- Supported locales: English and Arabic

When localization files change, run:

```bash
flutter gen-l10n
```

## Testing

Run all tests:

```bash
flutter test
```

Run static analysis:

```bash
flutter analyze
```

The test suite includes coverage for:

- Remote data sources
- Repository implementations
- Use cases
- Cubits and presentation state handling

## API

The app integrates with the Elevate Flower API:

```text
https://flower.elevateegy.com/api/v1
```

Main API areas include:

- Authentication and profile
- Products
- Categories
- Occasions
- Cart
- Orders
- Best sellers

The API constants are defined in:

```text
lib/core/values/api_endpoints.dart
```

## Development Notes

- Keep generated files updated after modifying annotated models or API clients.
- Prefer adding new features using the existing feature-first structure.
- Keep business logic in use cases and Cubits, not directly inside widgets.
- Add focused tests when changing repositories, use cases, or Cubit behavior.

