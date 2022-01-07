//
//  PostToCommunityViewController.swift
//  reddit-clone
//
//  Created by Uiseop Eom on 2022/01/05.
//

import UIKit

class PostToCommunityViewController: UIViewController {
    
    var searchController: UISearchController!
    var communityList: [Community] = []
    
    let defaults = UserDefaults.standard
    var isPaging: Bool = false
    var hasNextPage: Bool = false
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerView, searchView, tableView, UIView()])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy var headerView: UIView = {
        let view = UIStackView(arrangedSubviews: [dismissBT, UIView()])
        view.axis = .horizontal
        view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var dismissBT: UIButton = {
        let view = UIButton()
        view.backgroundColor = .purple
        let cancelImageConfig = UIImage.SymbolConfiguration(textStyle: .subheadline)
        let cancelImage = UIImage(
            systemName: "xmark",
            withConfiguration: cancelImageConfig
        )
        view.setImage(cancelImage, for: .normal)
        view.tintColor = .systemGray
        view.addTarget(self, action: #selector(pressDismiss), for: .touchUpInside)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        
        return view
    }()

    var searchView: UISearchBar = {
        let view = UISearchBar()
        //view.backgroundColor = .green
        return view
    }()
    

    var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let nib = UINib(nibName: "CommuTableViewCell", bundle: nil)
        view.register(nib, forCellReuseIdentifier: "CommuTableViewCell")
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let token = defaults.object(forKey: "token")
        if (token != nil) {
            networkRequest(_token: token as? String)
        }
    }

    func setupLayout() {
        // Stack View
        view.backgroundColor = .white
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true

        // Small Rectangle View
        dismissBT.heightAnchor.constraint(equalToConstant: 30).isActive = true
        dismissBT.leadingAnchor.constraint(equalTo: headerView.leadingAnchor).isActive = true
        dismissBT.widthAnchor.constraint(equalToConstant: 67).isActive = true
        //searchView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
        tableView.reloadData()
    }
    
    @objc
    func pressDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - pagination
    func paging() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.tableView.reloadData()
                self.isPaging = false
            }
    
    }
    
}

extension PostToCommunityViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
}


extension PostToCommunityViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communityList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "PostCreation", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PostCreationVCID") as? PostCreationViewController
        if let vc = vc {
            vc.modalPresentationStyle = .fullScreen
            vc.communityName = self.communityList[indexPath.row].name
            self.present(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CommuTableViewCell", for: indexPath) as! CommuTableViewCell
        cell.communityName.text = self.communityList[indexPath.row].name
        
        return cell
    }
}
