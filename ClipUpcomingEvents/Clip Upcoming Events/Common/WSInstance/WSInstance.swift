//
//  WSInstance.swift
//  Clip Upcoming Events
//
//  Created by christian hernandez rivera on 28/11/21.
//

import Foundation

class WSInstance {
    class func getAllEvents<T:Codable>(completion: @escaping (_ dataResponse: [T]) -> Void) {
        if let path = Bundle.main.path(forResource: "mock", ofType: "json") {
            
            do {
                guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else { return }
                completion(try JSONDecoder().decode([T].self, from: data))
            } catch {
                //error
                //completion(nil)
            }
        }
    }
}
