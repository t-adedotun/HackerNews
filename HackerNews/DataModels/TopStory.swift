//
//  TopStory.swift
//  HackerNews
//
//  Created by Taiwo on 19/10/2018.
//  Copyright © 2018 Taiwo. All rights reserved.
//

import Foundation

struct TopStory: Decodable {
    let title: String
    let kids: [Int]
}
