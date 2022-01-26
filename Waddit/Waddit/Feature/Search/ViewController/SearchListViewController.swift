import UIKit

class SearchListViewController: UIViewController, UISearchBarDelegate {
    var searchBar = UISearchBar()
    var cancelButton = UIButton()
    var searchData: [String] = []
    let searchHistoryTableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
        addSearchBar()
        addCancelButton()
        addTableView()
    }
    // MARK: - Add searchBar
    func addSearchBar() {
        searchBar.delegate = self
        view.addSubview(searchBar)
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -70).isActive = true
    }
    // MARK: - pull up keyboard when view appear
    override func viewWillAppear(_ animated: Bool) {
        self.searchBar.becomeFirstResponder()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchBar.resignFirstResponder()
    }
    // MARK: - Add cancelButton
    func addCancelButton() {
        view.addSubview(cancelButton)
        cancelButton.isUserInteractionEnabled = true
        cancelButton.addTarget(self, action: #selector(cancelButtonClicked(sender:)), for: .touchUpInside)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        cancelButton.setTitleColor(.systemGray, for: .normal)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:  12.5).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    // MARK: - Add tableView
    func addTableView() {
        self.searchHistoryTableView.dataSource = self
        self.searchHistoryTableView.delegate = self
        self.searchHistoryTableView.register(UITableViewCell.self,
                                forCellReuseIdentifier: "TableViewCell")
        view.addSubview(searchHistoryTableView)
        searchHistoryTableView.translatesAutoresizingMaskIntoConstraints = false
        searchHistoryTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
        searchHistoryTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchHistoryTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        searchHistoryTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
    }
}

extension SearchListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") else {return UITableViewCell()}
        cell.textLabel?.text = searchData[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    }
}

extension SearchListViewController {
    // MARK: - Set button click action
    @objc func cancelButtonClicked(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let vc = SearchResultViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
