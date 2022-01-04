import UIKit
import Tabman
import Pageboy

class SearchResultViewController: TabmanViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var justTextLabel: UILabel!
    @IBOutlet weak var barView: UIView!
    
    //set file name at nibName, defined at Home floder
    let nib = UINib(nibName: "PostTableViewCell",bundle: nil)
    
    //Tab bar libary
    private var viewControllers: Array<UIViewController> = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        //set button boarder
        searchButton.layer.cornerRadius = 5
        
        let SearchPostVC = UIStoryboard.init(name: "SearchPost", bundle: nil).instantiateViewController(withIdentifier: "SearchPostVCID") as! SearchPostViewController
        let SearchCommunityVC = UIStoryboard.init(name: "SearchCommunity", bundle: nil).instantiateViewController(withIdentifier: "SearchCommunityVCID") as! SearchCommunityViewController
        viewControllers.append(SearchPostVC)
        viewControllers.append(SearchCommunityVC)
        
        self.dataSource = self
        
        //create bar
        let bar = TMBar.ButtonBar()
        bar.backgroundView.style = .blur(style: .regular)
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        bar.buttons.customize{ (button) in
            button.tintColor = .gray
            button.selectedTintColor = .black}
        
        bar.indicator.weight = .light
        bar.indicator.tintColor = .systemIndigo
        bar.indicator.overscrollBehavior = .compress
        
        addBar(bar, dataSource: self, at: .custom(view: barView, layout: nil))
    }
    
    
    @IBAction func backButtonClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func searchButtonClick(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchVCID") as? SearchViewController else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
        
    }
}

extension SearchResultViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
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
