//
//  ImageRoverViewController.swift
//  NasaPhotoApp
//
//  Created by Александр Макаров on 01.10.2021.
//

import UIKit

class ImageRoverViewController: UIViewController {
    var fullPhoto: PhotoCuriosity!
    
    @IBOutlet var imageWithPhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.fetchImage(from: fullPhoto.imageSrc) { result in
            switch result {
            case .success(let imageData):
                self.imageWithPhoto.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }

    }
    
}
