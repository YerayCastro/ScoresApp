//
//  ScoresViewModel.swift
//  ScoresApp
//
//  Created by Yery Castro on 8/11/23.
//

import SwiftUI

/*:
 
 Tercea capa: Se crea el ViewModel. Siempre se crea en una clase. Y se ajusta al protocolo, "ObservableObject"
 
 */

final class ScoresViewModel: ObservableObject {
    
    // Aquí conseguimos la independencia de DataInteractor
    // Inyección de dependencias, para pasar los datos del Interactor al viewModel
    let interactor: Interactor
    
    // Se crea siempre con @Published(En las clases, es el equivalente @State). Aquí esta el almacen de los datos -> [Score]
    // Se crea una variable calculada con un didSet, para que los datos persistan, una vez se han borrado.
    @Published var scores: [Score] {
        didSet {
            try? interactor.saveData(json: scores)
        }
    }
    
    // Para sacar los compositores. Creando una variable calculada con los composers ordenados
    var composers: [String] {
        Array(Set(scores.map(\.composer))).sorted()
    }
    
    // Creamos un init porque scores no está inicializado
    // Se pasa una variable, de tipo Interactor(DataInteractor que es el modelo de producción). se inyecta la instancia de produccion, dandole por defecto ese valor.
    init (interactor: Interactor = DataInteractor()) {
        self.interactor = interactor
        do {
            scores = try interactor.loadData()
        } catch {
            print(error)
            scores = []
        }
    }
    // Función para borrar datos
    func deleteScore(index: IndexSet) {
        scores.remove(atOffsets: index)
    }
    // Función para recuperar el valor de ID
    func getScoreByID(id: Int) -> Score? {
        scores.first(where: { $0.id == id })
    }
    // Función para devolver las partituras de los compositores
    func getScoresFormComposer(composer: String) -> [Score] {
        scores.filter { score in
            score.composer == composer
        }
    }
    // Función para actualizar los valores
    func updateScore(score: Score) {
        if let index = scores.firstIndex(where: {$0.id == score.id }) {
            scores[index] = score
        }
    }
}
