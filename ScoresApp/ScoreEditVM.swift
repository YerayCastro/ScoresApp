//
//  ScoreEditVM.swift
//  ScoresApp
//
//  Created by Yery Castro on 11/11/23.
//

import SwiftUI
import PhotosUI

final class ScoreEditVM: ObservableObject {
    
    @Published var title = ""
    @Published var composer = ""
    @Published var year = 0
    @Published var length = 0.0
    
    let score: Score
    
    @Published var msg = ""
    @Published var showAlert = false
    
    @Published var tracks: [ScoreTracks]
    
    @Published var photo: PhotosPickerItem? {
        didSet {
            if let photo {
                photo.loadTransferable(type: Data.self) { result in
                    if case .success(let imageData) = result, 
                        let imageData, 
                        let image = UIImage(data: imageData),
                        let resize = image.resize(width: 300) {
                        DispatchQueue.main.async {
                            self.newCover = resize
                        }
                    }
                }
            }
        }
    }
    @Published var newCover: UIImage?
    
    init(score: Score) {
        self.score = score
        title = score.title
        composer = score.composer
        year = score.year
        length = score.length
        tracks = score.tracks.map {
            ScoreTracks(tracks: $0)
        }
        newCover = ImageInteractor.shared.loadImage(id: score.id)
    }
    
    // Función para borrar las tracks
    func deleteTrack(index: IndexSet) {
        tracks.remove(atOffsets: index)
    }
    
    // Función para validar el dato.
    func validateScore() -> Score? {
        var message = ""
        // Realizamos las comprobaciones
        if title.isEmpty || title.count > 200 {
            message += "Title cannot be empty or grater than 200 characters.\n"
        }
        if year < 1900 || year > 2050 {
            message += "Year must be between 1900 and 2050.\n"
        }
        if length <= 0 || length > 300 {
            message += "length must be greater than 0 and less than 300.\n"
        }
        // Si message está vacio, es que no ha habido ningún error
        if message.isEmpty {
            if let newCover {
                ImageInteractor.shared.saveImage(id: self.score.id, image: newCover)
            }
            return Score(id: score.id,
                         title: title,
                         composer: composer,
                         year: year,
                         length: length,
                         cover: score.cover,
                         tracks: tracks.map(\.tracks))
        } else {
            self.msg = String(message.dropLast())
            self.showAlert.toggle()
            return nil
        }
    }
}
