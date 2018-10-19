//
//  CommentsProtocol.swift
//  HackerNews
//
//  Created by Taiwo on 19/10/2018.
//  Copyright © 2018 Taiwo. All rights reserved.
//

import Foundation

protocol CommentsProtocol {
    func getComments(completion: @escaping(_ newsItems: [String]) -> Void)
    var title: String { get }
}
