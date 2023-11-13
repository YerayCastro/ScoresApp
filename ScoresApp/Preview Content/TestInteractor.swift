//
//  TestInteractor.swift
//  ScoresApp
//
//  Created by Yery Castro on 8/11/23.
//

import Foundation

/*:
 
  Crear el interactor para manejar los datos de prueba.
 
 */

// url de test
struct TestInteractor: Interactor {
    // 1º. Obtención de la url del json
    let urlBundle = Bundle.main.url(forResource: "scoresdatatest", withExtension: "json")!
    // 3º. Acceso a la carpeta de documentos general,para poder editar los datos. Se añade al path: scoresdata.json
    let docURL = URL.documentsDirectory.appending(path: "scoresdatatest.json")
}

// Creo una extensión para poder pasar datos de prueba.
extension ScoresViewModel {
    // Se crea una variable static, para poder compartirla por todos los sitios
    static let preview = ScoresViewModel(interactor: TestInteractor())
}

// Extensión para crear un dato de prueba, para pasarselo a la preview
extension Score {
    static let test = Score(id: 1, title: "Star Wars", composer: "John Williams", year: 1977, length: 70, cover: "StarWars", tracks: [
        "Main Title", "Imperial Attack", "Princess Leia's Theme", "The Desert and the Robot Auction", "Ben's Death and TIE Fighter Attack", "The Little People Work", "Rescue of the Princess", "Inner City", "Cantina Band", "The Land of the Sand People", "Mouse Robot and Blasting Off", "The Return Home", "The Walls Converge", "The Princess Appears", "The Last Battle", "The Throne Room and End Title"])
}
