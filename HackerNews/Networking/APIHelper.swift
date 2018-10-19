//
//  APIHelper.swift
//  HackerNews
//
//  Created by Taiwo on 18/10/2018.
//  Copyright © 2018 Taiwo. All rights reserved.
//

import Foundation

struct APIHelper: Networker {

    func makeGetRequest(url: String, completion: @escaping (Data) -> Void) {
        let session = URLSession(configuration: .default)

        guard let urlFromString = URL(string: url) else {
            fatalError("String could not be converted to URL.")
        }

        (session.dataTask(with: urlFromString) { data, response, error in
            if error != nil {
                print ("An error occurred: \(String(describing: error?.localizedDescription))")
            }

            if let data = data {
                completion(data)
            } else {
                print ("No data returned from API.")
            }
        }).resume()
    }
}
