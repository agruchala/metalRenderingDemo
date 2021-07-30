//
//  Filter.swift
//  metalDemo
//
//  Created by Artur Gruchała on 29/07/2021.
//

import CoreImage
import UIKit

final class Filter {
    private let oryginalImage: CIImage
    private let filter = CIFilter(name: "CIColorControls")!
    init(with image: UIImage) {
        oryginalImage = CIImage(image: image)!
        filter.setValue(oryginalImage, forKey: "inputImage")
    }
    
    func filter(saturation: NSNumber) -> CIImage {
        filter.setValue(saturation, forKey: kCIInputSaturationKey)
        return filter.outputImage!
    }
}
