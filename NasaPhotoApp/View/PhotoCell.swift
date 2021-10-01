//
//  PhotoCell.swift
//  NasaPhotoApp
//
//  Created by Александр Макаров on 30.09.2021.
//

import UIKit

class PhotoCell: UITableViewCell {

    //MARK: - AB Outlets
    @IBOutlet var imageWithPhoto: UIImageView!
    @IBOutlet var roverNameLabel: UILabel!
    
    @IBOutlet var cameraNameLabel: UILabel!
    @IBOutlet var solLabel: UILabel!
    
    func configure(with photoCuriosity: PhotoCuriosity) {
        guard let solNumber = photoCuriosity.sol else { return }
        solLabel.text = String(solNumber)
        roverNameLabel.text = photoCuriosity.rover?.name
        cameraNameLabel.text = photoCuriosity.camera?.name
        
        NetworkManager.shared.fetchImage(from: photoCuriosity.imageSrc) { result in
            switch result {
            case .success(let imageData):
                self.imageWithPhoto.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
            
        }
        
    }

}
