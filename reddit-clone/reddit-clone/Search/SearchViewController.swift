//
//  SearchViewController.swift
//  reddit-clone
//
//  Created by MinWoo Park on 2021/12/22.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.searchBar.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchResultVCID") as? SearchResultViewController else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)

    }
    
    @IBAction func Cacnel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
