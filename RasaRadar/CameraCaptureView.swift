//
//  CameraCaptureView.swift
//  RasaRadar
//
//  Created by Fakhrul Fauzi on 03/04/2025.
//

import SwiftUI
import AVFoundation
import Vision

struct CameraCaptureView: UIViewControllerRepresentable {
    @Binding var capturedImage: UIImage?
    @Binding var classificationResult: String?
    
    func makeUIViewController(context: Context) -> CameraCaptureViewController {
        let controller = CameraCaptureViewController()
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: CameraCaptureViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, CameraCaptureViewControllerDelegate {
        let parent: CameraCaptureView
        
        init(_ parent: CameraCaptureView) {
            self.parent = parent
        }
        
        func didCaptureImage(_ image: UIImage) {
            parent.capturedImage = image
            classify(image: image)
        }
        
        private func classify(image: UIImage) {
            guard let cgImage = image.cgImage else {
                parent.classificationResult = "Failed to process image"
                return
            }
            
            guard let model = try? VNCoreMLModel(for: MalaysianFoodClassifier().model) else {
                parent.classificationResult = "Failed to load model"
                return
            }
            
            let request = VNCoreMLRequest(model: model) { request, error in
                guard let results = request.results as? [VNClassificationObservation],
                      let topResult = results.first else {
                    self.parent.classificationResult = "No results found"
                    return
                }
                self.parent.classificationResult = "\(topResult.identifier) (\(Int(topResult.confidence * 100))%)"
            }
            
            let handler = VNImageRequestHandler(cgImage: cgImage)
            try? handler.perform([request])
        }
    }
}

protocol CameraCaptureViewControllerDelegate: AnyObject {
    func didCaptureImage(_ image: UIImage)
}

class CameraCaptureViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    var captureSession: AVCaptureSession!
    var photoOutput: AVCapturePhotoOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    weak var delegate: CameraCaptureViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }
    
    private func setupCamera() {
        // Initialize the capture session
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        // Configure the camera input
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video),
              let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice),
              captureSession.canAddInput(videoInput) else {
            print("Error: Unable to access the camera.")
            return
        }
        captureSession.addInput(videoInput)
        
        // Configure the photo output
        photoOutput = AVCapturePhotoOutput()
        guard captureSession.canAddOutput(photoOutput) else {
            print("Error: Unable to add photo output.")
            return
        }
        captureSession.addOutput(photoOutput)
        
        // Configure the preview layer
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        // Add a circular capture button
        let buttonSize: CGFloat = 70
        let captureButton = UIButton(frame: CGRect(x: (view.frame.width - buttonSize) / 2, y: view.frame.height - buttonSize - 100, width: buttonSize, height: buttonSize))
        captureButton.backgroundColor = .white
        captureButton.layer.cornerRadius = buttonSize / 2
        captureButton.layer.borderWidth = 5
        captureButton.layer.borderColor = UIColor.systemGray4.cgColor
        captureButton.addTarget(self, action: #selector(capturePhoto), for: .touchUpInside)
        view.addSubview(captureButton)
        
        // Start the capture session
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
    }
    
    @objc private func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        settings.flashMode = .auto
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else {
            print("Error: Unable to process captured photo.")
            return
        }
        
        // Notify the delegate with the captured image
        delegate?.didCaptureImage(image)
        
        // Dismiss the camera view
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Stop the capture session
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.stopRunning()
        }
    }
}
