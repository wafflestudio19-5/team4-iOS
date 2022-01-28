import UIKit
import Tabman
import Pageboy

class BaseFeedViewController: BaseTabViewController {

    let tabManVC = SlideTabViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addChildVC()
    }

    private func addChildVC() {
        addChild(tabManVC)
        let navBarHight = self.navigationController!.navigationBar.frame.height + self.navigationController!.navigationBar.frame.midY
        view.addSubview(tabManVC.view)
        tabManVC.view.anchor(.top(view.topAnchor, constant: navBarHight),
                             .leading(view.leadingAnchor, constant: 0), .trailing(view.trailingAnchor, constant: 0), .height(view.frame.height))
        tabManVC.didMove(toParent: self)
    }
}

extension BaseFeedViewController {
    // MARK: - select searchButton
    @objc func searchButtonClicked(sender: UIButton!) {
        let vc = SearchListViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
