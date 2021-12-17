//
//  LatestSortViewController.swift
//  reddit-clone
//
//  Created by MinWoo Park on 2021/12/15.
//

import UIKit

class LatestSortViewController: UIViewController {
    
    @IBOutlet weak var postTableView: UITableView!
    
    //set file name at nibName
       let nib = UINib(nibName: "PostTableViewCell",bundle: nil)
    
    override func viewDidLoad() {
        
        //set postTableView delegate and register xib
               postTableView.delegate = self
               postTableView.dataSource = self
               postTableView.register(nib, forCellReuseIdentifier: "PostTableViewCell")
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

 extension LatestSortViewController : UITableViewDelegate, UITableViewDataSource {
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 10
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = postTableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as? PostTableViewCell else { return UITableViewCell() }
         return cell
     }
     
 }
