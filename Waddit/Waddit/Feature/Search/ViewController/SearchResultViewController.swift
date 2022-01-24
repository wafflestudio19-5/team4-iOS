import UIKit
import Tabman
import Pageboy

class SearchResultViewController: TabmanViewController {
    var backButton = UIButton()
    var searchBar = UISearchBar()
    var searchKeywordLabel = UILabel()
    var resultLabel = UILabel()
    let barView = UIView()
    let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
    // Tab bar libary
    private var viewControllers: [UIViewController] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackButton()
        addSearchBar()
        addSearchKeywordLabel()
        addResultLabel()
        addTabBarView()
        addViewController()
    }
    // MARK: - Add backButton
    func addBackButton() {
        view.addSubview(backButton)
            // arrow.backward
        let selectedImageOriginal = UIImage(systemName: "arrow.backward")
        let selectedImage = selectedImageOriginal?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(selectedImage, for: .normal)
        backButton.tintColor = .systemGray
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12.5).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    // MARK: - Add searchBar
    func addSearchBar() {
        view.addSubview(searchBar)
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: backButton.trailingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
    }
    // MARK: - Add SearchKeywordLabel
    func addSearchKeywordLabel() {
        view.addSubview(searchKeywordLabel)
        searchKeywordLabel.text = "Search Data"
        searchKeywordLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        searchKeywordLabel.translatesAutoresizingMaskIntoConstraints = false
        searchKeywordLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
        searchKeywordLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
    }
    // MARK: - Add resultLabel, that just display 'Search results'
    func addResultLabel() {
        view.addSubview(resultLabel)
        resultLabel.text = "Search results"
        resultLabel.textColor = .systemGray
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.topAnchor.constraint(equalTo: searchKeywordLabel.bottomAnchor, constant: 5).isActive = true
        resultLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
    }
    // MARK: - Set tabBar ui
    func addTabBarView() {
        view.addSubview(barView)
        barView.backgroundColor = .white
        barView.translatesAutoresizingMaskIntoConstraints = false
        barView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 10).isActive = true
        barView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        barView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        barView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        barView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        barView.backgroundColor = .white
    }
    // MARK: - Add viewcontroller to custom tabBar
    func addViewController() {
        let searchPostVC = SearchPostViewController()
        viewControllers.append(searchPostVC)
        self.dataSource = self
        // MARK: - create bar
        let bar = TMBar.ButtonBar()
        barView.addSubview(bar)
        bar.backgroundView.style = .blur(style: .regular)
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        bar.buttons.customize { (button) in
            button.tintColor = .gray
            button.selectedTintColor = .black
        }
        bar.indicator.weight = .light
        bar.indicator.tintColor = .systemIndigo
        bar.indicator.overscrollBehavior = .compress
        addBar(bar, dataSource: self, at: .custom(view: barView, layout: nil))
    }
}

// MARK: - Code for custom tabBar
extension SearchResultViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "Posts")
        case 1:
            return TMBarItem(title: "Communites")
        case 2:
            return TMBarItem(title: "Users")
        default:
            return TMBarItem(title: "test")
        }
    }
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count

    }
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}

// MARK: - Code for using canvas
import SwiftUI

struct SearchResultViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = SearchResultViewController

    func makeUIViewController(context: Context) -> SearchResultViewController {
        return SearchResultViewController()
    }

    func updateUIViewController(_ uiViewController: SearchResultViewController, context: Context) {
    }
}

@available(iOS 13.0.0, *)
struct SearchResultViewControllerPreview: PreviewProvider {
    static var previews: some View {
        SearchResultViewControllerRepresentable()
.previewInterfaceOrientation(.portrait)
    }
}
