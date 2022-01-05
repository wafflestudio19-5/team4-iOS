//
//  PostToCommunityViewController.swift
//  reddit-clone
//
//  Created by Uiseop Eom on 2022/01/05.
//

import UIKit

class PostToCommunityViewController: UIViewController {
    
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
    

    var tableView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchView.delegate = self
        setupLayout()
        print(stackView.frame)
    }

    func setupLayout() {
        // Stack View
        view.backgroundColor = .white
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true

        // Small Recntangle View
        dismissBT.heightAnchor.constraint(equalToConstant: 30).isActive = true
        dismissBT.leadingAnchor.constraint(equalTo: headerView.leadingAnchor).isActive = true
        dismissBT.widthAnchor.constraint(equalToConstant: 67).isActive = true
        //searchView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true

    }
    
    @objc
    func pressDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PostToCommunityViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        // TODO: add animation
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
}


