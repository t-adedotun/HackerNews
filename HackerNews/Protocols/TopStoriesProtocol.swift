//
//  TopStoriesProtocol.swift
//  HackerNews
//
//  Created by Taiwo on 19/10/2018.
//  Copyright © 2018 Taiwo. All rights reserved.
//

import Foundation

protocol TopStoriesProtocol {
    func getTopNews(completion: @escaping(_ newsItems: [TopStory]) -> Void)
    var title: String { get }
}

