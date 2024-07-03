//
//  DetailViewController.swift
//  Challenge 1 - 100 days of swift
//
//  Created by Enzo Rossetto on 03/07/24.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var viewTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewTitle
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        guard let selectedImageName = selectedImage else {
            print("No selected image")
            return
        }
        
        let atCharacterPosition = selectedImageName.firstIndex(of: "@") ?? selectedImageName.endIndex
        let countryName = selectedImageName[..<atCharacterPosition].uppercased()
        
        let vc = UIActivityViewController(activityItems: [image, countryName], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
