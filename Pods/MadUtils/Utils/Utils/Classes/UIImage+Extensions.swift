//
//  UIImage+Extensions.swift
//  Utils
//
//  Created by Николай Садчиков on 31/05/2019.
//  Copyright © 2019 wearemad. All rights reserved.
//

import UIKit

extension UIImage {
    
    public func fixOrientation() -> UIImage? {
        if self.imageOrientation == .up {
            return self
        }
        
        // We need to calculate the proper transformation to make the image upright.
        // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
        var transform = CGAffineTransform.identity
        
        switch self.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: CGFloat.pi)
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height)
            transform = transform.rotated(by: -CGFloat.pi / 2)
        default:
            break
        }
        
        switch self.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        default:
            break
        }
        
        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        guard let context = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0, space: self.cgImage!.colorSpace!, bitmapInfo: self.cgImage!.bitmapInfo.rawValue) else {
            return nil
        }
        
        context.concatenate(transform)
        
        switch self.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            context.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: self.size.height, height: self.size.width))
        default:
            context.draw(self.cgImage!, in: CGRect(origin: .zero, size: self.size))
        }
        
        // And now we just create a new UIImage from the drawing context
        guard let CGImage = context.makeImage() else {
            return nil
        }
        
        return UIImage(cgImage: CGImage)
    }
    
    public func imageRotatedByDegrees(degrees: CGFloat) -> UIImage {
        var size = self.size
        size = CGSize(width: size.height, height: size.width)
        UIGraphicsBeginImageContext(size)
        
        let bitmap: CGContext = UIGraphicsGetCurrentContext()!
        //Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap.translateBy(x: size.width / 2, y: size.height / 2)
        //Rotate the image context
        //Now, draw the rotated/scaled image into the context
        bitmap.scaleBy(x: -1.0, y: 1.0)
        
        let origin = CGPoint(x: -size.width / 2, y: -size.height / 2)
        
        bitmap.draw(self.cgImage!, in: CGRect(origin: origin, size: size))
        
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    public func resizeImage(_ dimension: CGFloat, opaque: Bool, contentMode: UIView.ContentMode = .scaleAspectFit) -> UIImage {
        var newImage: UIImage
        let size = self.size
        let scaleFactor = dimension/size.width
        let newHeight = size.height * scaleFactor
        let newWidth = size.width * scaleFactor
        
        let renderFormat = UIGraphicsImageRendererFormat.default()
        renderFormat.opaque = opaque
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: newWidth, height: newHeight), format: renderFormat)
        newImage = renderer.image {
            (context) in
            self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        }
        return newImage
    }
}
