//
//  SubscriptionsViewController.swift
//  reddit-clone
//
//  Created by Uiseop Eom on 2021/11/28.
//

import UIKit
import Tabman
import Pageboy

class SubscriptionsViewController: TabmanViewController {
    
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var barView: UIView!
    
    // Tab bar library
    private var viewControllers: Array<UIViewController> = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // TODO: To be modified
        // set button boarder
        searchButton.layer.cornerRadius = 5
        initVCs()
        
        self.dataSource = self
        
        let buttonBar = createBar()
        addBar(buttonBar, dataSource: self, at: .custom(view: barView, layout: nil))

    }
    
    fileprivate func initVCs() {
        let commuListVC = UIStoryboard.init(name: "CommuList", bundle: nil).instantiateViewController(withIdentifier: "CommuListVCID") as! CommuListViewController
        
        let customFeedVC = UIStoryboard.init(name: "CustomFeedList", bundle: nil).instantiateViewController(withIdentifier: "CustomFeedListVCID") as! CustomFeedListViewController
        
        self.viewControllers.append(commuListVC)
        self.viewControllers.append(customFeedVC)
    }
    
    // create bar
    fileprivate func createBar() -> TMBar.ButtonBar {
        let bar = TMBar.ButtonBar()
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
        return bar
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension SubscriptionsViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "Communities")
        case 1:
            return TMBarItem(title: "Custom Feeds")
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
