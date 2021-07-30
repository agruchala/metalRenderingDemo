//
//  ViewController.swift
//  metalDemo
//
//  Created by Artur Gruchała on 27/07/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loadImageButton: UIBarButtonItem!
    @IBOutlet weak var adjustmentSlider: UISlider!
    @IBOutlet weak var imageRenderingContainerView: MetalView!
    private var filter: Filter?
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loadImageDidTap(_ sender: UIBarButtonItem) {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self
        present(imagePickerVC, animated: true)
    }
    
    @IBAction func sliderDidChange(_ sender: UISlider) {
        guard let filter = filter else { return }
        imageRenderingContainerView.image = filter.filter(saturation: NSNumber(value: sender.value))
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[.originalImage] as? UIImage {
            filter = Filter(with: image)
            imageRenderingContainerView.image = filter?.filter(saturation: NSNumber(value: adjustmentSlider.value))
        }
    }
}

