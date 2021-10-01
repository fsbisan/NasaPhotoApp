//
//  PhotoOfSpace.swift
//  NasaPhotoApp
//
//  Created by Александр Макаров on 26.09.2021.
//
import Foundation

struct PhotoOfADay: Decodable {
    var url: String?
    var hdurl: String?
    var title: String?
    var explanation: String?
    var mediaType: MediaType?
    
    init(photo: [String: Any]) {
        url = photo["url"] as? String
        hdurl = photo["hdurl"] as? String
        title = photo["title"] as? String
        explanation = photo["explanation"] as? String
        if photo["media_type"] as? String == "video" {
            mediaType = .video
        } else { mediaType = .photo }
    }
    
    static func getPhotoOfADay(from value: Any) -> PhotoOfADay {
        guard let photoOfADay = value as? [String: Any] else { return PhotoOfADay(photo: [:]) }
        let photo = PhotoOfADay(photo: photoOfADay)
        return photo
    }
}

enum MediaType: Decodable {
    case video
    case photo
}

struct PhotoCuriosity: Decodable {
    var sol: Int?
    var camera: Camera?
    var imageSrc: String?
    var rover: Rover?
    
    init(photoCuriosity: [String: Any]) {
        sol = photoCuriosity["sol"] as? Int
        
        let cameraDict = photoCuriosity["camera"] as? [String: Any] ?? [:]
        camera = Camera(camera: cameraDict)
        
        imageSrc = photoCuriosity["img_src"] as? String
        
        let roverDict = photoCuriosity["rover"] as? [String: Any] ?? [:]
        rover = Rover(rover: roverDict)
    }
    
    static func getPhotosCuriosity(from value: Any) -> [PhotoCuriosity] {
        guard let photosCuriosityData = value as? [String: Any] else { return [] }
        guard let photosCur = photosCuriosityData["photos"] as? [[String: Any]] else { return [] }
//        var photosCuriosity: [PhotoCuriosity] = []
//        for photoCur in photosCur {
//            let photo = PhotoCuriosity(photoCuriosity: photoCur)
//            photosCuriosity.append(photo)
//        }
//        return photosCuriosity
// this code do same as function below
        return photosCur.compactMap { PhotoCuriosity(photoCuriosity: $0) }
        }
    }

struct Camera: Decodable {
    var name: String?
    
    init(camera: [String: Any]) {
        name = camera["name"] as? String
        }
}

struct Rover: Decodable {
    var name: String?
    
    init(rover: [String: Any]) {
        name = rover["name"] as? String
    }
}



