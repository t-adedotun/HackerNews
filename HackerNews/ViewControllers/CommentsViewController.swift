//
//  CommentsViewController.swift
//  HackerNews
//
//  Created by Taiwo on 19/10/2018.
//  Copyright © 2018 Taiwo. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    @IBOutlet weak var cellTextView: UITextView!
}

class CommentsViewController: UITableViewController {

    private var activityView: UIActivityIndicatorView!
    private var comments: [String] = []

    var viewModel: CommentsProtocol? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = viewModel?.title

        activityView = UIActivityIndicatorView(style: .gray)
        activityView.center = self.tableView.center
        self.tableView.addSubview(activityView)
        activityView.startAnimating()

        viewModel?.getComments { comments in
            self.comments = comments

            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityView.stopAnimating()
            }
        }
    }
}

// MARK: - Table view data source

extension CommentsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsComment", for: indexPath) as? CommentCell

        guard let nonNilCell = cell else {
            return UITableViewCell()
        }

        nonNilCell.cellTextView.text = comments[indexPath.row]

        return nonNilCell
    }
}

