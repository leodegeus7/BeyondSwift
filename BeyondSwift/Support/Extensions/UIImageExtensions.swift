//
//  UIImageExtensiosn.swift
//  BeyondSwift
//
//  Created by Leonardo Geus on 06/02/19.
//  Copyright © 2019 Leonardo Geus. All rights reserved.
//

import UIKit

extension UIImage{
    
    func multiply(color:UIColor) -> UIImage? {
        let rect = CGRect(origin: .zero, size: self.size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        let filter = CIFilter(name: "CIPhotoEffectMono")
        let ciInput = CIImage(image: self)
        filter?.setValue(ciInput, forKey: "inputImage")
        let ciOutput = filter?.outputImage
        let ciContext = CIContext()
        let cgImage = ciContext.createCGImage(ciOutput!, from: (ciOutput?.extent)!)
        color.setFill()
        UIRectFill(rect)
        let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
        context!.setFillColor(UIColor.white.cgColor)
        context!.fill(rect)
        UIImage(cgImage: cgImage!).draw(in: rect, blendMode: .normal, alpha: 1)
        coloredImage?.draw(in: rect, blendMode: .multiply, alpha: 1)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}
