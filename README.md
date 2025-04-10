
# RasaRadar

RasaRadar is an iOS application that helps users discover and classify Malaysian foods using CoreML and Vision frameworks. The model was trained locally on Apple device (MacBook Pro M1) with impressive accuracy. The app allows users to capture images of food, classify them using a machine learning model, and view detailed information about the identified food.

## Features

- **Food Classification**: Classify Malaysian foods using a CoreML model (`MalaysianFoodClassifier.mlmodel`).
- **Camera Integration**: Capture food images directly within the app using the device's camera.
- **Food Information**: View detailed information about the classified food, including calories and a description.
- **Modern UI**: A clean and intuitive user interface built with SwiftUI.


## Key Files

- **`ContentView.swift`**: The main entry point of the app, providing navigation to the `ProcessView`.
- **`ProcessView.swift`**: Handles the camera integration, food classification, and navigation to the `FoodInfoView`.
- **`CameraCaptureView.swift`**: Implements the camera functionality using `UIViewControllerRepresentable` and integrates with Vision for image classification.
- **`FoodInfoView.swift`**: Displays detailed information about the classified food, including its name, calories, and description.
- **`MalaysianFoodClassifier.mlmodel`**: The CoreML model used for food classification.

## Requirements

- iOS 16.0 or later
- Xcode 14.0 or later
- Swift 5.0 or later

## Setup Instructions

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd RasaRadar
   ```

2. Open the project in Xcode:
   ```bash
   open RasaRadar.xcodeproj
   ```

3. Ensure the `MalaysianFoodClassifier.mlmodel` file is included in the project.

4. Build and run the app on a simulator or physical device.

## Usage

1. Launch the app.
2. Tap "Let's Start!" to navigate to the `ProcessView`.
3. Use the "Scan Food" button to capture an image of the food.
4. View the classification result and tap "View Food Info" to see detailed information about the food.

## Results

![Training and Validation Accuracy](./showcase/rasaradar_result.png)

The `MalaysianFoodClassifier.mlmodel` was trained using Apple's Create ML framework with the Malaysian Food Dataset. The training process achieved the following results:

- **Training Accuracy**: 94.2%
- **Validation Accuracy**: 93.2%
- **Iterations**: The model converged early at 26 iterations.

These results indicate that the model performs well in classifying Malaysian foods, with a high level of accuracy during both training and validation phases. The early convergence suggests that the model was able to learn the dataset effectively without overfitting.

The graph below illustrates the training and validation accuracy over the iterations:

The model is expected to perform reliably in real-world scenarios, provided the input images are clear and representative of the training data.

## Permissions

The app requires camera access to capture food images. Ensure the following key is added to the `Info.plist` file:

```xml
<key>NSCameraUsageDescription</key>
<string>This app requires camera access to scan food items.</string>
```

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Acknowledgments

- [Malaysian Food Dataset](https://www.kaggle.com/datasets/karkengchan/malaysia-food-11)
- CoreML and Vision frameworks for enabling machine learning and image processing.
- SwiftUI for building a modern and responsive user interface.

---

**Developed by Fakhrul Fauzi**
