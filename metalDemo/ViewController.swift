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
    @IBOutlet weak var imageRenderingContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loadImageDidTap(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func sliderDidChange(_ sender: UISlider) {
    }
    
}

