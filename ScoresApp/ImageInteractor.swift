//
//  ImageInteractor.swift
//  ScoresApp
//
//  Created by Yery Castro on 13/11/23.
//

import SwiftUI

struct ImageInteractor {
    static let shared = ImageInteractor()
    
    let urlDoc = URL.documentsDirectory
    
    // Función para cargar imágenes.
    func loadImage(id: Int) -> UIImage? {
        let url = urlDoc.appending(path: "cover\(id).jpg")
        if FileManager.default.fileExists(atPath: url.path()) {
            do {
                let data = try Data(contentsOf: url)
                return UIImage(data: data)
            } catch {
                print("Error al cargar la imágen \(id).")
            }
        }
        return nil
    }
    
    // Función para guardar imágenes.
    func saveImage(id: Int, image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.7) else { return }
        let url = urlDoc.appending(path: "cover\(id).jpg")
        try? data.write(to: url, options: .atomic)
    }
}
