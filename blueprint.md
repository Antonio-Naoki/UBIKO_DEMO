# Project Blueprint

## Overview

This document outlines the development of a Flutter application that integrates a map with real-time location tracking. The application has been built with a focus on a clean, scalable architecture and a modern user interface.

## Core Features

*   **Interactive Map:** Displays an interactive map using the `flutter_map` package.
*   **Real-time Location:** Tracks and displays the user's current location on the map with a marker.
*   **Permissions Handling:** Gracefully requests and handles location permissions using the `permission_handler` package.
*   **State Management:** Utilizes `flutter_bloc` for robust state management of the user's location.
*   **Dependency Injection:** Uses `provider` for dependency injection of the `ThemeProvider` and `LocationBloc`.
*   **Modern UI:** Implements a visually appealing and user-friendly interface with `google_fonts` and Material Design 3, including a theme toggle for light and dark modes.
*   **Map Controls:** Includes a button to fetch the user's location and a button to recenter the map on the user's current location.

## Application Structure

*   **`main.dart`:** The main entry point of the application. It sets up the `MaterialApp`, `ThemeProvider`, and `LocationBloc`.
*   **`map_page.dart`:** The screen that displays the map. It uses `flutter_map` to display the map and `flutter_bloc` to manage the location state. It also includes buttons to fetch the user's location and recenter the map.
*   **`location_service.dart`:** A service class that handles location updates from the `geolocator` package and location permissions.
*   **`location_bloc.dart`:** A BLoC that manages the location state, including fetching the user's location and handling errors.
*   **`location_event.dart`:** The events for the `LocationBloc`.
*   **`location_state.dart`:** The states for the `LocationBloc`.

## Current Plan

The application is now feature-complete based on the initial request. Future improvements could include:

*   **Real-time Location Updates:** Stream the user's location to provide real-time updates on the map.
*   **Custom Map Markers:** Use custom markers to display the user's location.
*   **Error Handling:** Implement more robust error handling for location services.
*   **UI/UX Enhancements:** Further improve the UI and user experience of the application.
