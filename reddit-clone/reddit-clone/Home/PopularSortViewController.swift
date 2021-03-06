//
//  PopularSortViewController.swift
//  reddit-clone
//
//  Created by MinWoo Park on 2021/12/15.
//

import UIKit

class PopularSortViewController: UIViewController {

    
    @IBOutlet weak var postTableView: UITableView!
    
    var postDataList: [PostGetData] = []
    
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let token = defaults.object(forKey: "token")
        if (token != nil) {
            networkRequest(_token: token as? String)
        }
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.postTableView.reloadData()
                self.isPaging = false
            }
    
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let height = scrollView.frame.height
            
            //start pagination
            if offsetY > (contentHeight - height) {
                if isPaging == false {
                    isPaging = true
                    // reload cell
                    DispatchQueue.main.async {
                        let token = self.defaults.object(forKey: "token")
                        if (token != nil) {
                            self.networkRequest(_token: token as? String)
                        }
                    }
                            
                    // ????????? ????????? ??????
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.paging()
                    }
            }
        }
    }
}

 extension PopularSortViewController : UITableViewDelegate, UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if self.postDataList == nil {return 0}
         return self.postDataList.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = postTableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as? PostTableViewCell else { return UITableViewCell() }
         cell.titleLabel.text = postDataList[indexPath.row].title
         cell.postDataLabel.text = postDataList[indexPath.row].text
         cell.postId = postDataList[indexPath.row].id
        return cell
     }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "PostVCID") as? PostViewController else {return}
         vc.modalPresentationStyle = .fullScreen
         vc.modalTransitionStyle = .crossDissolve
         vc.postNum = self.postDataList[indexPath.row].id
         self.present(vc, animated: true, completion: nil)
     }
 }

