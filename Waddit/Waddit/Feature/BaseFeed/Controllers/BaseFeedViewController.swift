import UIKit
import Tabman
import Pageboy

class BaseFeedViewController: TabmanViewController {
    let sideButton = UIButton()
    let searchButton = UIButton()
    let barView = UIView()
    var id: String?
    var token: String?
    // set file name at nibName
    let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
    // Tab bar libary
    private var viewControllers: [UIViewController] = []
    // UserDefaluts
    override func viewDidLoad() {
        super.viewDidLoad()
        addSideButton()
        addSearchButton()
        addTabBarView()
        addViewController()
        view.backgroundColor = .white
    }
    // MARK: - Set sideMenuButton ui
    func addSideButton() {
        view.addSubview(sideButton)
        let iconOriginal = UIImage(systemName: "externaldrive.connected.to.line.below")
        let icon = iconOriginal?.withRenderingMode(.alwaysTemplate)
        sideButton.setImage(icon, for: .normal)
        sideButton.tintColor = .systemGray
        sideButton.translatesAutoresizingMaskIntoConstraints = false
        sideButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25.0).isActive = true
        sideButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -45).isActive = true
        sideButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        sideButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    // MARK: - Set searchButton ui
    func addSearchButton() {
        view.addSubview(searchButton)
        let searchImageOriginal = UIImage(systemName: "magnifyingglass")
        let searchImage = searchImageOriginal?.withRenderingMode(.alwaysTemplate)
        searchButton.setImage(searchImage, for: .normal)
        searchButton.setTitle("Search", for: .normal)
        searchButton.layer.cornerRadius = 5
        searchButton.backgroundColor = .systemGray6
        searchButton.setTitleColor(.gray, for: .normal)
        searchButton.tintColor = .systemGray
        searchButton.contentHorizontalAlignment = .leading
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: -35).isActive = true
        searchButton.leadingAnchor.constraint(equalTo: sideButton.trailingAnchor, constant: 20.0).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -80).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        }
    // MARK: - Set tabBar ui
    func addTabBarView() {
        view.addSubview(barView)
        barView.backgroundColor = .white
        barView.translatesAutoresizingMaskIntoConstraints = false
        barView.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 10).isActive = true
        barView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        barView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        barView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        barView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        barView.backgroundColor = .white
    }
    // MARK: - Add viewcontroller to custom tabBar
    func addViewController() {
        let latestVC = LatestSortFeedViewController()
        viewControllers.append(latestVC)
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
extension BaseFeedViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "Popular")
        case 1:
            return TMBarItem(title: "Latest")
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

struct BaseFeedViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = BaseFeedViewController

    func makeUIViewController(context: Context) -> BaseFeedViewController {
        return BaseFeedViewController()
    }

    func updateUIViewController(_ uiViewController: BaseFeedViewController, context: Context) {
    }
}

@available(iOS 13.0.0, *)
struct BaseFeedViewPreview: PreviewProvider {
    static var previews: some View {
        BaseFeedViewControllerRepresentable()
    }
}
