//
//  NetworkingProtocol.swift
//  HackerNews
//
//  Created by Taiwo on 19/10/2018.
//  Copyright © 2018 Taiwo. All rights reserved.
//

import Foundation

protocol Networker {
    func makeGetRequest(url: String, completion: @escaping(_ data: Data) -> Void)
}
