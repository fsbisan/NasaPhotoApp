//
//  PhotosCuriosityViewController.swift
//  NasaPhotoApp
//
//  Created by Александр Макаров on 29.09.2021.
//

import UIKit

class PhotosCuriosityViewController: UITableViewController {
    
    var photosCuriosity: [PhotoCuriosity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photosCuriosity.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! PhotoCell
        
        let photoCuriosity = photosCuriosity[indexPath.row]
        
        cell.configure(with: photoCuriosity)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "full Photo", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let imageRoverVC = segue.destination as? ImageRoverViewController else { return }
        guard let cellNumber = sender as? Int else { return }
        imageRoverVC.fullPhoto = photosCuriosity[cellNumber]
    }
    
    func alamofireGetPhotoCuriosityButtonPressed() {
        NetworkManager.shared.fetchPhotoCuriosityWithAlamofire(url: Links.photoOfCuriosity.rawValue) { result in
            switch result {
            case .success(let photosCuriosity):
                self.photosCuriosity = photosCuriosity
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
