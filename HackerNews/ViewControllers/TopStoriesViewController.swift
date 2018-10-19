//
//  ViewController.swift
//  HackerNews
//
//  Created by Taiwo on 18/10/2018.
//  Copyright © 2018 Taiwo. All rights reserved.
//

import UIKit

class TopStoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var activityView: UIActivityIndicatorView!

    private var topStories: [TopStory] = []

    private var viewModel: TopStoriesViewModel = TopStoriesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        self.title = viewModel.title

        activityView = UIActivityIndicatorView(style: .gray)
        activityView.center = self.tableView.center
        self.tableView.addSubview(activityView)
        activityView.startAnimating()

        viewModel.getTopNews { topStories in
            self.topStories = topStories
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityView.stopAnimating()
            }
        }
    }

}

extension TopStoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topStories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topStoryCell", for: indexPath)

        cell.textLabel?.text = (topStories[indexPath.row]).title

        return cell
    }
}

extension TopStoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let commentsVC = storyboard?.instantiateViewController(withIdentifier: "CommentsViewController") as? CommentsViewController

        commentsVC?.viewModel = CommentsViewModel(commentIds: (topStories[indexPath.row]).kids)

        self.navigationController?.pushViewController(commentsVC!, animated: true)
    }
}

