//
//  ModelData.swift
//  Landmark
//
//  Created by Raramuri on 29/07/24.
//

import Foundation

@Observable
class ModelData{
    var landmark: [Landmark] = load("landmarkData.json")
}

func load<T: Decodable> (_ filename: String) -> T {
    let data: Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else{
        fatalError("Not Found \(filename) in main")
    }
    do{
        data = try Data(contentsOf: file)
    } catch{
        fatalError("Not Found \(filename) in main \(error)")
    }
    
    do{
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    catch{
        fatalError("Not Found \(filename)  as \(T.self):\n\(error)")
    }
}
