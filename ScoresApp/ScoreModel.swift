//
//  ScoreModel.swift
//  ScoresApp
//
//  Created by Yery Castro on 8/11/23.
//

import Foundation

/*:
 
 Primera capa: Crear el Modelo(Model)
 
 */

struct Score: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let composer: String
    let year: Int
    let length: Double
    let cover: String
    let tracks: [String]
}

extension Score {
    var lengthS: String {
        "\(length.formatted(.number.precision(.integerAndFractionLength(integer: 2, fraction: 1)))) min."
    }
    
    var yearS: String {
        year.formatted()
    }
}
struct ScoreTracks: Identifiable {
    let id = UUID()
    var tracks: String
}
