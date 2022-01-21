import UIKit

class SearchListViewController: UIViewController {
    var searchBar = UISearchBar()
    var cancelButton = UIButton()
    var searchData: [String] = []
    let searchHistoryTableView = UITableViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        addSearchBar()
        addCancelButton()
        addTableView()
    }
    // MARK: - Add searchBar
    func addSearchBar() {
        view.addSubview(searchBar)
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -70).isActive = true
    }
    // MARK: - Add cancelButton
    func addCancelButton() {
        view.addSubview(cancelButton)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        cancelButton.setTitleColor(.systemGray, for: .normal)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:  12.5).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    func addTableView() {
    }
}

// MARK: - Code for using canvas
import SwiftUI

struct SearchListViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = SearchListViewController

    func makeUIViewController(context: Context) -> SearchListViewController {
        return SearchListViewController()
    }

    func updateUIViewController(_ uiViewController: SearchListViewController, context: Context) {
    }
}

@available(iOS 13.0.0, *)
struct SearchListViewControllerPreview: PreviewProvider {
    static var previews: some View {
        SearchListViewControllerRepresentable()
.previewInterfaceOrientation(.portrait)
    }
}
