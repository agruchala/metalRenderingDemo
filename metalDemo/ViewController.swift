//
//  ViewController.swift
//  metalDemo
//
//  Created by Artur Gruchała on 27/07/2021.
//

import UIKit
import CoreImage
import Metal
import MetalKit

class ViewController: UIViewController {

    @IBOutlet weak var loadImageButton: UIBarButtonItem!
    @IBOutlet weak var adjustmentSlider: UISlider!
    var queue: MTLCommandQueue!
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    var mltView: MTKView!
    private var filter: Filter?
    var context: CIContext!
    override func viewDidLoad() {
        super.viewDidLoad()
        let metalDevice = MTLCreateSystemDefaultDevice()!
        mltView = MTKView(frame: .zero, device: metalDevice)
        mltView.framebufferOnly = false
        context = CIContext(mtlDevice: metalDevice)
        queue = metalDevice.makeCommandQueue()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mltView.frame = view.bounds
        view.addSubview(mltView)
        view.bringSubviewToFront(adjustmentSlider)
    }

    @IBAction func loadImageDidTap(_ sender: UIBarButtonItem) {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self
        present(imagePickerVC, animated: true)
    }
    
    @IBAction func sliderDidChange(_ sender: UISlider) {
        guard let filter = filter else { return }
        renderImage(image: filter.filter(saturation: NSNumber(value: sender.value)))
    }
    
    private func renderImage(image: CIImage) {
        let drawable = mltView.currentDrawable!
        let buffer = queue.makeCommandBuffer()!
        
        let widthScale = mltView.drawableSize.width / image.extent.width
        let heightScale = mltView.drawableSize.height / image.extent.height
        
        let scale = min(widthScale, heightScale)
        
        let scaledImage = image.transformed(by: CGAffineTransform(scaleX: scale, y: scale))
        
        let yPos = mltView.drawableSize.height / 2 - scaledImage.extent.height / 2
        
        let bounds = CGRect(x: 0, y: -yPos, width: mltView.drawableSize.width, height: mltView.drawableSize.height)
        
        context.render(scaledImage,
                       to: drawable.texture,
                       commandBuffer: buffer,
                       bounds: bounds,
                       colorSpace: colorSpace)
        buffer.present(drawable)
        buffer.commit()
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[.originalImage] as? UIImage {
            filter = Filter(with: image)
            renderImage(image: filter!.filter(saturation: NSNumber(value: 1)))
        }
    }
}

