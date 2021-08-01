//
//  ImageClassificationModel.swift
//  ImageCoreML
//
//  Created by Daval Cato on 8/1/21.
//

import UIKit
import CoreML
import Vision
import ImageIO

final class ImageClassificationModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var classificationText: String = ""
    
    private func processClassifications(for request: VNRequest, error: Error?) {
        
        guard let results = request.results else { self.classificationText = "Unable to classify this image!\n\(error!.localizedDescription)"; return}
        let classifications = results as! [VNClassificationObservation]
        
        if classifications.isEmpty {
            self.classificationText = "Nothing recognized!"
        } else {
            let topClassifications = classifications.prefix(2)
            let descriptions = topClassifications.map { classification in
                return String(format: "%.2f %@", classification.confidence, classification.identifier)
            }
            self.classificationText = "Classification:\n" + descriptions.joined(separator: "\n")
        }
        
    }
    
}







