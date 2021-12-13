//
//  HomeViewController.swift
//  reddit-clone
//
//  Created by Uiseop Eom on 2021/11/28.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var postTableView: UITableView!

    @IBOutlet weak var searchButton: UIButton!
    
    //set file name at nibName
    let nib = UINib(nibName: "PostTableViewCell",bundle: nil)
    
    
    override func viewDidLoad() {
        
        //set postTableView delegate and register xib
        postTableView.delegate = self
        postTableView.dataSource = self
        postTableView.register(nib, forCellReuseIdentifier: "PostTableViewCell")
        
        //set button boarder
        searchButton.layer.cornerRadius = 5
        super.viewDidLoad()
        
    }
    
    /*
     func tableView(_ tableView: UITableView, rowForHeightAt indexPath: IndexPath) -> CGFloat {
         return 1000
            //return tableView.rowHeight
        }
     */
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 160
            //return tableView.rowHeight
         }
}


extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = postTableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as? PostTableViewCell else { return UITableViewCell() }
        return cell
    }
    
}
