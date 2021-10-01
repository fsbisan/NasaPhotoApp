//
//  ImageViewController.swift
//  NasaPhotoApp
//
//  Created by Александр Макаров on 26.09.2021.
//

import UIKit

class ImageViewController: UIViewController {
    @IBOutlet var explanation: UILabel!
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var photo = PhotoOfADay(photo: [:])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.isHidden = true
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        alamofireGetPhotoOfADayButtonPressed()
    }
    
    private func setDataOfPhoto(in photoOfADay: PhotoOfADay) {
        titleLabel.text = photoOfADay.title
        explanation.text = photoOfADay.explanation
        activityIndicator.stopAnimating()
        titleLabel.isHidden = false
        NetworkManager.shared.fetchImage(from: photoOfADay.url) { result in
            switch result {
            case .success(let imageData):
                self.imageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
    func alamofireGetPhotoOfADayButtonPressed() {
        NetworkManager.shared.fetchPhotoWithAlamofire(url: Links.photoOfADayLink.rawValue) { result in
            switch result {
            case .success(let photo):
                self.photo = photo
                self.setDataOfPhoto(in: self.photo)
            case .failure(let error):
                print(error)
            }
        }
    }
}
