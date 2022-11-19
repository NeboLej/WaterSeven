//
//  WSImageManager.swift
//  WaterSeven
//
//  Created by Nebo on 19.11.2022.
//

import UIKit

class WSImageManager {
    
    func saveImage(imageName: String, image: UIImage) {

     guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }

        //Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch {
                print("couldn't remove file at path", error)
            }
        }

        do {
            try data.write(to: fileURL)
        } catch {
            print("error saving file with error", error)
        }
    }

    func loadImageFromDiskWith(fileName: String) -> String? {

      let documentDirectory = FileManager.SearchPathDirectory.documentDirectory

        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)

        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
//            let image = UIImage(contentsOfFile: imageUrl.path)
            return imageUrl.path

        }

        return nil
    }
    
}
