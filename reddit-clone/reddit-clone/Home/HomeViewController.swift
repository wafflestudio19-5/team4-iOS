//
//  HomeViewController.swift
//  reddit-clone
//
//  Created by Uiseop Eom on 2021/11/28.
//

import UIKit
import Tabman
import Pageboy

class HomeViewController: TabmanViewController, LoginProtocol {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var barView: UIView!
    
    var id: String?
    var token: String?
    
    //set file name at nibName
    let nib = UINib(nibName: "PostTableViewCell",bundle: nil)
    
    //Tab bar libary
    private var viewControllers: Array<UIViewController> = []
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //set button boarder
        searchButton.layer.cornerRadius = 5
        
        let popularSortVC = UIStoryboard.init(name: "PopularSort", bundle: nil).instantiateViewController(withIdentifier: "PopularSortVCID") as! PopularSortViewController
        let latestSortVC = UIStoryboard.init(name: "LatestSort", bundle: nil).instantiateViewController(withIdentifier: "LatestSortVCID") as! LatestSortViewController
        viewControllers.append(popularSortVC)
        viewControllers.append(latestSortVC)
        
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
    
    
    @IBAction func searchButton(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchVCID") as? SearchViewController else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
    
    func SendLoginData(_id: String, _token: String) {
        id = _id
        token = _token
    }
    
}

extension HomeViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
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
