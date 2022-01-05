//
//  PopularSortViewController.swift
//  reddit-clone
//
//  Created by MinWoo Park on 2021/12/15.
//

import UIKit

class PopularSortViewController: UIViewController {

    
    @IBOutlet weak var postTableView: UITableView!
    
    var postDataList: [PostGetData]?
    
    let defaults = UserDefaults.standard
    
    var isPaging: Bool = false
    var hasNextPage: Bool = false
    
    //set file name at nibName
       let nib = UINib(nibName: "PostTableViewCell",bundle: nil)
    
    override func viewDidLoad() {
        
        //set postTableView delegate and register xib
        postTableView.delegate = self
        postTableView.dataSource = self
        postTableView.register(nib, forCellReuseIdentifier: "PostTableViewCell")
        super.viewDidLoad()
        paging()

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
    
    //MARK: - pagination
    func paging() {
        let index = postDataList?.count
        
        //loading data
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.postTableView.reloadData()
            }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let height = scrollView.frame.height
            
            //start pagination
            if offsetY > (contentHeight - height) {
                if isPaging == false && hasNextPage {
                    isPaging = true
                    // reload cell
                    DispatchQueue.main.async {
                        self.postTableView.reloadSections(IndexSet(integer: 1), with: .none)
                    }
                            
                    // 페이징 메소드 호출
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.paging()
                    }
            }
        }
    }
}

 extension PopularSortViewController : UITableViewDelegate, UITableViewDataSource {
     
    func numberOfSections(in tableView: UITableView) -> Int {
            return 2
        }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if postDataList == nil {return 0}
            return postDataList!.count
        }
        else if section == 1 && isPaging && hasNextPage {
            return 1
        }
        return 0
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = postTableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as? PostTableViewCell else { return UITableViewCell() }
            cell.titleLabel.text = postDataList?[indexPath.row].title
            cell.postId = postDataList?[indexPath.row].id ?? nil
            return cell
        }
        
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingTableViewCell", for: indexPath) as? LoadingTableViewCell else { return UITableViewCell() }
        return cell
        }
     }
     
 }

