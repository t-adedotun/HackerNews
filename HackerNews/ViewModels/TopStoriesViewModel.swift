//
//  ViewControllerViewModel.swift
//  HackerNews
//
//  Created by Taiwo on 18/10/2018.
//  Copyright © 2018 Taiwo. All rights reserved.
//

import Foundation

struct TopStoriesViewModel: TopStoriesProtocol {

    var title: String { return "Top Stories" }

    let networker: Networker = APIHelper()

    func getTopNews(completion: @escaping(_ newsItems: [TopStory]) -> Void) {
        networker.makeGetRequest(url: "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty") { data in

            do {
                guard let returnedArray = try JSONSerialization.jsonObject(with: data, options: []) as? [Int] else {
                    return
                }

                let topStories = returnedArray.count > 20 ? Array(returnedArray[..<20]) : returnedArray

                var news: [TopStory] = []

                for (index, newsId) in topStories.enumerated() {
                    self.networker.makeGetRequest(url: "https://hacker-news.firebaseio.com/v0/item/\(newsId).json") { data in

                        do {
                            let jsonDecoder = JSONDecoder()
                            let newsItem = try jsonDecoder.decode(TopStory.self, from: data)
                            news.append(newsItem)

                            // call completion handler only after getting all news items
                            if (index + 1 == topStories.count) {
                                completion(news)
                            }
                        } catch {
                            print ("Couldn't decode JSON: \(error.localizedDescription)")
                        }
                    }
                }

            } catch {
                print ("Couldn't read returned data: \(error.localizedDescription)")
            }
        }
    }
}
