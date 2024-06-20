# Options Strategy Analyzer

A Flutter app to analyze the risk and reward of options trading strategies. It supports up to four options contracts and visualizes their combined profit/loss on a graph.

## Features

- Input up to four options contracts (calls or puts).
- Generate a risk and reward graph with the underlying asset's price on the X-axis and profit/loss on the Y-axis.
- Display max profit, max loss, and break-even points.

## Architecture

- **Flutter** for UI development.
- **BloC (Business Logic Component)** for state management.
- **SOLID principles** and **Design Patterns** for clean, maintainable, and scalable code.

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) installed on your machine.

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/options_strategy_analyzer.git

2. Navigate to the project directory:
    ```bash
        cd aries-flutter-challenge

3. Install dependencies:
    ```bash
        flutter pub get

4. Run App
    ```bash
        flutter run

### Project Structure
###### lib/blocs/: 
Contains the BloC for managing state.
###### lib/events/: 
Defines the events for the BloC.
###### lib/states/: 
Defines the states for the BloC.
###### lib/models/: 
Contains the data models and DTOs.
###### lib/repositories/: 
Contains the repository for handling business logic and data processing.
###### lib/ui/: 
Contains the UI components.
###### lib/main.dart: 
Entry point of the application.
### Usage
Launch the app.
Add options contracts through the provided UI.
View the risk and reward graph along with key metrics (max profit, max loss, and break-even points).

### Screens: 
![Alt text](screens/photo_2024-06-20_12-18-50.jpg?raw=true "Title")
![Alt text](screens/video_2024-06-20_12-18-18-ezgif.com-video-to-gif-converter.gif?raw=true "Title")

