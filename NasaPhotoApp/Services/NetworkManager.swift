//
//  NetworkManager.swift
//  NasaPhotoApp
//
//  Created by Александр Макаров on 29.09.2021.
//

import Foundation
import Alamofire

enum Links: String {
    case photoOfADayLink = "https://api.nasa.gov/planetary/apod?api_key=8czehGNgChh5ijEK37pni4vYeialPL8JJPueCIMO"
    case photoOfCuriosity = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&page=2&api_key=8czehGNgChh5ijEK37pni4vYeialPL8JJPueCIMO"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func fetchPhotoWithAlamofire(url: String, completion: @escaping(Result<PhotoOfADay, NetworkError>) -> Void ){
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let photoOfADay = PhotoOfADay.getPhotoOfADay(from: value)
                    DispatchQueue.main.async {
                        completion(.success(photoOfADay))
                    }
                case .failure:
                    completion(.failure(.decodingError))
                }
            }
    }
    
    func fetchPhotoCuriosityWithAlamofire(url: String, completion: @escaping(Result<[PhotoCuriosity], NetworkError>) -> Void ){
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let photoCuriosity = PhotoCuriosity.getPhotosCuriosity(from: value)
                    print(photoCuriosity)
                    DispatchQueue.main.async {
                        completion(.success(photoCuriosity))
                    }
                case .failure:
                    completion(.failure(.decodingError))
                }
            }
    }
}

