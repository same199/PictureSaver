//
//  SaveLoadManager.swift
//  PictureSaver
//
//  Created by Artsiom Stulba on 21.12.25.
//

import Foundation
import UIKit

enum Keys: String {
    case pin
}


final class SaveLoadManager {
    
    private let defaults = UserDefaults.standard
    
    func save(_ pin: String) {
        defaults.set(pin, forKey: Keys.pin.rawValue)
    }
    
    func load(for key:Keys) -> String? {
        return defaults.string(forKey: key.rawValue)
    }
//    func saveImage(image: UIImage) -> String?{
//        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
//        
//        let filename = UUID().uuidString
//        let fileDirectory = directory.appendingPathComponent(filename)
//        
//        guard let data = image.pngData() else {return nil}
//        
//        do {
//            try data.write(to: fileDirectory)
//            return filename
//        }
//        catch let error{
//            print(error.localizedDescription)
//            return nil
//        }
//    }
//    
//    func loadImage (filename: String) -> UIImage? {
//        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
//        let fileURL = directory.appendingPathComponent(filename)
//        return UIImage(contentsOfFile: fileURL.path)
//    }
//    
//    func saveImageName(_ text: String) {
//        defaults.set(text, forKey: Keys.imageName.rawValue)
//    }
//    
//    func loadImageName() -> String? {
//        defaults.string(forKey:  Keys.imageName.rawValue)
//    }
}

