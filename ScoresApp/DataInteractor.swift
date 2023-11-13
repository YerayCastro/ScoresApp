//
//  DataInteractor.swift
//  ScoresApp
//
//  Created by Yery Castro on 8/11/23.
//

import Foundation

/*:
 
 Segunda capa: Interactor. Crear el interactor.
 
 */

// Creo un protocolo Interactor. Con las variables urlBundle de tipo {get} y la variable docURL de tipo {get}. Y también las funciones loadData y saveData()
protocol Interactor {
    var urlBundle: URL { get }
    var docURL: URL { get }
    
    func loadData<T>() throws -> T where T: Codable
    func saveData<T>(json: T) throws where T: Codable
}

// Conformo con el protocolo Interactor creado, Y dejo solo las urls.
struct DataInteractor: Interactor {
    // 1º. Obtención de la url del json
    let urlBundle = Bundle.main.url(forResource: "scoresdata", withExtension: "json")!
    // 3º. Acceso a la carpeta de documentos general,para poder editar los datos. Se añade al path: scoresdata.json
    let docURL = URL.documentsDirectory.appending(path: "scoresdata.json")
}

// Creo una extension de Interactor, con las funciones. Y en el DataInteractor dejo solo las urls.
// Laa extensión creada, es para tipos genéricos, por lo que puedo usarla en cualquier sitio.
extension Interactor {
    // 2º. Cargar el dato.Para que el viewModel, lo envíe a la view
    func loadData<T>() throws -> T where T: Codable {
        // Comprobar si el fichero de docURL existe
        var url = docURL
        // Si la url no existe, cambio la url por la del Bundle.
        if !FileManager.default.fileExists(atPath: url.path()) {
            url = urlBundle
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    // 4º. Para grabar los datos. Pasamos como argumento [Score] porque no esta en el DataInteractor.
    func saveData<T>(json: T) throws where T: Codable {
        // Para que se grabe en disco, lo primero es obtener el data
        // Usamos JSONEncoder para pasar los datos del json en bruto
        let data = try JSONEncoder().encode(json)
        // Para escribir los datos(data) en la carpeta de documentos. Se pones siempre la opción .atomic
        try data.write(to: docURL, options: .atomic)
    }
}
