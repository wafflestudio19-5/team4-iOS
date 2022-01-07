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
    
<<<<<<< Updated upstream
=======
    //MARK: - pagination
    func paging() {
        let testData = PostGetData(id: 0, userId: 1, title: "test", text: "Test Test", images: [], numUpVotes: 0, numDownVotes: 0)
        for _ in 1...10 {
            self.postDataList.append(testData)
        }
        //loading data
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
>>>>>>> Stashed changes
}

 extension LatestSortViewController : UITableViewDelegate, UITableViewDataSource {
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
<<<<<<< Updated upstream
         return 10
=======
         return self.postDataList.count
>>>>>>> Stashed changes
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = postTableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as? PostTableViewCell else { return UITableViewCell() }
         return cell
     }
     
 }
