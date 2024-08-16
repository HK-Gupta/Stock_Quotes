# Stocks App

## Overview
The Stocks App is a mobile application developed using Flutter that allows users to search for stocks, add them to their watchlist or portfolio, and track their real-time performance. The app integrates Firebase for user authentication, the Alpha Vantage API for stock data, and manages state using the flutter_bloc package.

## Features
- **User Authentication**: Securely create accounts, log in, and manage profile information using Firebase.
- **Stock Search**: Search for stocks by symbols and country, view detailed charts spanning 1 year, and access comprehensive stock information.
- **Watchlist & Portfolio**: Add up to 50 stocks to your watchlist, view current prices and percentage changes, and track purchases with real-time balance updates.
- **Firebase Integration**: Used for authentication and real-time database updates.
- **State Management**: Managed efficiently with flutter_bloc.
- **Responsive Design**: Optimized for both iOS and Android platforms.

## Screenshots
<table>
  <tr align="center">
     <td>Home Page</td>
     <td>Details</td>
     <td>Watchlist</td>
     <td>Portfolio</td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/b7ecf8ee-307f-4dc7-a469-123aa2be43eb" width="200"></td>
    <td><img src="https://github.com/user-attachments/assets/4508bccb-1fc6-45f7-849e-8117d18cf033" width="200"></td>
    <td><img src="https://github.com/user-attachments/assets/f3ac7f38-c3c0-45de-867f-29581a9574c3" width="200"></td>
    <td><img src="https://github.com/user-attachments/assets/1d796a3a-f53b-44e0-babc-bd3aa096e99d" width="200"></td>
  </tr>
</table>

## Installation

### Prerequisites
- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- An editor like Android Studio or Visual Studio Code

### Steps
1. **Clone the repository:**
    ```sh
    git clone https://github.com/HK-Gupta/Stock_Quotes.git
    ```

2. **Navigate to the project directory:**
    ```sh
    cd stocks-app
    ```

3. **Get the dependencies:**
    ```sh
    flutter pub get
    ```

4. **Set up Firebase:**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable Firebase Firestore and Authentication
   - Enable Google Sign-In in the Authentication section
   - Download the `google-services.json` file and place it in the `android/app` directory

5. **Set up the Alpha Vantage API:**
   - Sign up at [Alpha Vantage](https://www.alphavantage.co/support/#api-key) to get your API key.
   - Add your Alpha Vantage API key to the `.env` file.

