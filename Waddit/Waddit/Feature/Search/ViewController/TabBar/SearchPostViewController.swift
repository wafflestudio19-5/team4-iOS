import UIKit

class SearchPostViewController: UIViewController {
    var postTableView = UITableView()
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        addPostTableView()
        //getData(pageNum: 0)
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
        postTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 175).isActive = true
        postTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        postTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        postTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 50).isActive = true
    }
}

// MARK: - Code for postTableView
extension SearchPostViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier) as? PostTableViewCell else { return PostTableViewCell() }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let vc = ReadPostViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
// MARK: - Code for using canvas
import SwiftUI

    struct SearchPostViewControllerRepresentable: UIViewControllerRepresentable {
        typealias UIViewControllerType = SearchPostViewController

        func makeUIViewController(context: Context) -> SearchPostViewController {
            return SearchPostViewController()
        }

        func updateUIViewController(_ uiViewController: SearchPostViewController, context: Context) {
        }
    }

    @available(iOS 13.0.0, *)
    struct SearchPostViewPreview: PreviewProvider {
        static var previews: some View {
            SearchPostViewControllerRepresentable()
        }
    }

