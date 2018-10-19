//
//  CommentsViewModel.swift
//  HackerNews
//
//  Created by Taiwo on 19/10/2018.
//  Copyright © 2018 Taiwo. All rights reserved.
//

import Foundation

struct CommentsViewModel: CommentsProtocol {

    private let networker: Networker = APIHelper()
    private var commentIds: [Int]

    var title: String { return "Comments" }

    init(commentIds: [Int]) {
        self.commentIds = commentIds.count > 5 ? Array(commentIds[..<5]) : commentIds
    }

    func getComments(completion: @escaping(_ comments: [String]) -> Void) {
        var commentItems: [String] = []

        commentIds.forEach { commentId in
            networker.makeGetRequest(url: "https://hacker-news.firebaseio.com/v0/item/\(commentId).json") { data in
                do {
                    let jsonDecoder: JSONDecoder = JSONDecoder()
                    let comment = try jsonDecoder.decode(Comment.self, from: data)
                    commentItems.append(self.formatComment(comment))
                    completion(commentItems)
                } catch {
                    print ("Problem decoding JSON: \(error.localizedDescription)")
                }
            }
        }
    }

    private func formatComment(_ comment: Comment) -> String {
        var formattedCommentText: NSAttributedString = NSAttributedString(string: "Unable to load comment")
        let dataFromText = comment.text.data(using: .utf8)

        if let data = dataFromText {
            do {
                formattedCommentText = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            } catch {
                print("Could not format HTML text: \(error.localizedDescription)")
            }
        }

        return "\(comment.by):\n \(formattedCommentText.string)"
    }
}
