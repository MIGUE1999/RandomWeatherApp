# 🌦️ Random Weather App  
iOS application developed in SwiftUI that displays the current weather for a random location in the world.

---

## 📌 Solution Description

This app generates a **valid random location** (latitude between -90 and 90, longitude between -180 and 180) and fetches weather information using the public **OpenWeather API**.

Each time the app loads, it displays:

- City name (if there is no city name available, it will show "Unknown City")
- Weather description  
- Icon representing the weather  
- Temperature  
- Latitude and longitude used  

The user can **refresh the location** to fetch the weather for a new random location.

---

## 🏛️ Architecture

The app follows a **clean, modular, and testable architecture** based on **layers** and **SOLID principles**. The **Presentation Layer** uses **MVVM** to separate UI from business logic:

### **Data Layer**
- *Data sources*:  
  - `WeatherRemoteDataSource`
  - `LocationLocalDataSource`   
- *Services*:  
  - `WeatherService`  
- *Mapper*:  
  - `WeatherEntityMapper` (maps network entities to domain models)
  - 'LocationEntityMapper` 

### **Domain Layer**
- *Repository*:  
  - `WeatherRepository`
  - `LocationRepository`
- *Use Cases*:  
  - `GetRandomLocationUseCase`  
  - `GetWeatherUseCase`

### **Presentation Layer**
- `WeatherDetailViewModel`  
- `WeatherDetailView`

---

## 🧪 Tests

The app includes **unit tests** for all code except the UI.  

Following SOLID principles makes the code easily testable. *Mocks* are used to isolate dependencies and ensure each component can be tested individually.

---

## 🔑 API Key Management

To avoid exposing the API key directly in the bundle, a secure approach was used:

✔ **Basic obfuscation**  
The API key is reconstructed from separate parts to avoid hardcoding it in the code.

---

## 🛠️ Technologies

- Swift 5  
- SwiftUI  
- Combine  
- Async/Await  
- URLSession  
- XCTest  
- Xcode 16

---

## 📱 How to Run

1. Clone the repository  
2. Open `.xcodeproj` or `.xcworkspace`  
4. Run on a simulator or device

---

## 📸 App Screenshot

<img src="https://github.com/user-attachments/assets/85db5e0a-348e-4a27-9479-dfc3daf39e6e" alt="App Screenshot" width="400" />

---

## 📄 Notes

- The code is organized to maximize testability, clarity, and separation of concerns.  
- Network requests, validations, and mappings are decoupled from the UI.  
- Logging has been added to help with debugging.
