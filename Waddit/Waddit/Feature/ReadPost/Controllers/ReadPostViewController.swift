//
//  ReadPostViewController.swift
//  Waddit
//
//  Created by MinWoo Park on 2022/01/17.
//

import UIKit

class ReadPostViewController: UIViewController {
    var postTableView = UITableView()
    var postData: specificPostData?
    static let identifier = "ReadPostViewController"
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        addPostTableView()
    }
    func setNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = .systemGray4
    }
    // MARK: - Add post TableView
    func addPostTableView() {
        postTableView.dataSource = self
        postTableView.delegate = self
        postTableView.estimatedRowHeight = 160
        postTableView.rowHeight = UITableView.automaticDimension
        postTableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        view.addSubview(postTableView)
        postTableView.translatesAutoresizingMaskIntoConstraints = false
        postTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        postTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        postTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        postTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 50).isActive = true
    }

}
// MARK: - Code for postTableView
extension ReadPostViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier) as? PostTableViewCell
            else { return PostTableViewCell() }
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentLabelTableViewCell.identifier) as? CommentLabelTableViewCell
            else { return CommentLabelTableViewCell() }
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier) as? CommentTableViewCell
        else { return CommentTableViewCell() }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
// MARK: - Code for using canvas
import SwiftUI

struct ReadPostViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = ReadPostViewController

    func makeUIViewController(context: Context) -> ReadPostViewController {
        return ReadPostViewController()
    }

    func updateUIViewController(_ uiViewController: ReadPostViewController, context: Context) {
    }
}

@available(iOS 13.0.0, *)
struct ReadPostViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ReadPostViewControllerRepresentable()
    }
}
