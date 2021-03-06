//
//  ImagePicker.swift
//  ImageCoreML
//
//  Created by Daval Cato on 8/1/21.
//

import SwiftUI

final class ImagePickerCoordinator: NSObject {
    @Binding var image: UIImage?
    @Binding var takePhoto: Bool
    
    
    init(image: Binding<UIImage?>, takePhoto: Binding<Bool>) {
        _image = image
        _takePhoto = takePhoto
        
    }
}

struct ShowImagePicker: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    @Binding var takePhoto: Bool
    
    func makeCoordinator() -> ImagePickerCoordinator {
        ImagePickerCoordinator(image: $image, takePhoto: $takePhoto)
        
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        
        let pickController = UIImagePickerController()
        pickController.delegate = context.coordinator
        
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return pickController }
        
        switch self.takePhoto {
            
        case true:
            pickController.sourceType = .camera
        case false:
            pickController.sourceType = .photoLibrary
        }
        pickController.allowsEditing = true
        return pickController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
}

extension ImagePickerCoordinator: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        self.image = uiImage
        picker.dismiss(animated: true)
    }
}















