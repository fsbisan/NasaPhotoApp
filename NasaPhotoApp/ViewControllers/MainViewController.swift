//
//  CollectionViewController.swift
//  NasaPhotoApp
//
//  Created by Александр Макаров on 26.09.2021.
//

import UIKit

enum UserAction: String, CaseIterable {
    case getPhotoOfADay = "Get Photo of a Day"
    case getPhotosOfCuriosity = "Get Photos of Curiosity"
}

class MainViewController: UICollectionViewController {
    let userActions = UserAction.allCases
    
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UserActionCell
    
        let userAction = userActions[indexPath.item]
        cell.userActionLabel.text = userAction.rawValue
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        switch userAction {
            
        case .getPhotoOfADay:
            performSegue(withIdentifier: "image", sender: nil)
        case .getPhotosOfCuriosity:
            performSegue(withIdentifier: "table", sender: nil)
        }
    }
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "image" {
            let photosCuriosityVC = segue.destination as! PhotosCuriosityViewController
            photosCuriosityVC.alamofireGetPhotoCuriosityButtonPressed()
        }
            
    }
}

//extension MainViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        CGSize.init(width: UIScreen.main.bounds.width - 40, height: 100)
//    }
//}
