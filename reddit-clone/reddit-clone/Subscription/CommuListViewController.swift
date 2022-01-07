//
//  CommuListViewController.swift
//  reddit-clone
//
//  Created by Uiseop Eom on 2021/12/18.
//
//  A table view controller for comunities list

import UIKit

class CommuListViewController: UIViewController {
    
    @IBOutlet weak var commuTableView: UITableView!
    var communityList: [Community] = []
    
    // set file name at nibName
    let nib = UINib(nibName: "CommuTableViewCell", bundle: nil)
    var isPaging: Bool = false
    var hasNextPage: Bool = false
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        // set postTableView delegate and register xib
        //self.commuTableView.backgroundColor = .red
        commuTableView.delegate = self
        commuTableView.dataSource = self
        commuTableView.register(nib, forCellReuseIdentifier: "CommuTableViewCell")
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        commuTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let token = defaults.object(forKey: "token")
        if (token != nil) {
            networkRequest(_token: token as? String)
        }
    }

    func paging() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.commuTableView.reloadData()
            self.isPaging = false
        }
    }


}

extension CommuListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return communityList.count
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = commuTableView.dequeueReusableCell(withIdentifier: "CommuTableViewCell") as? CommuTableViewCell else { return UITableViewCell() }
        cell.communityName.text = "r/" + communityList[indexPath.row].name
        return cell
    }
}
