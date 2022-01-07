//
//  PostCreationViewController.swift
//  reddit-clone
//
//  Created by Uiseop Eom on 2021/11/28.
//

import UIKit

class PostCreationViewController: UIViewController {

    @IBOutlet weak var cancelBT: UIButton!
    @IBOutlet weak var proceedBT: UIButton!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var communityBT: UIButton!
    
    @IBOutlet weak var titleTextField: UITextView!
    @IBOutlet weak var bodyTextField: UITextView!
    
    @IBOutlet weak var inputTypes: UIStackView!
    @IBOutlet weak var guideBT: UIButton!
    
    let defaults = UserDefaults.standard
    var token: String?
    
    var communityName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setHeaderView()
        //setMainView()
        setInputTypeView()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func setHeaderView() {
        // cancel button
        cancelBT.setTitle("", for: .normal)
        let cancelImageConfig = UIImage.SymbolConfiguration(textStyle: .subheadline)
        let cancelImage = UIImage(
            systemName: "xmark",
            withConfiguration: cancelImageConfig
        )
        cancelBT.setImage(cancelImage, for: .normal)
        cancelBT.tintColor = .systemGray
        
        cancelBT.addTarget(self, action: #selector(dismissBTpressed), for: .touchUpInside)
        
        communityBT.setTitle(communityName, for: .normal)
        communityBT.addTarget(self, action: #selector(moveToCommunitySelection), for: .touchUpInside)
        
        proceedBT.setTitle("Next", for: .normal)
        proceedBT.addTarget(self, action: #selector(postCreate), for: .touchUpInside)
        guideBT.setTitle("Rules", for: .normal)
    }
    
    fileprivate func setInputTypeView() {
        inputTypes.translatesAutoresizingMaskIntoConstraints = false
        let inputTypesViewConstraints = [
            inputTypes.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            inputTypes.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            inputTypes.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            inputTypes.heightAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(inputTypesViewConstraints)
    }
    
    fileprivate func setMainView() {
        mainView.backgroundColor = .red
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.topAnchor.constraint(equalTo: communityBT.bottomAnchor, constant: 100).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        print("====================================", titleTextField.frame.origin.y)
    }
    @objc
    func postCreate() {
        self.token = defaults.object(forKey: "token") as? String
        if titleTextField.text == nil { return }
        
        let dataWillPost: PostData = PostData(title: titleTextField.text, text: bodyTextField.text, community: communityName)
        
        let postData = jsonEncodingData(postData: dataWillPost)
        networkRequest(data: postData!, token: self.token)
        
    }
    
    @objc
    func moveToCommunitySelection() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func dismissBTpressed() {
        let pvc = self.presentingViewController?.presentingViewController
        pvc!.dismiss(animated: true, completion: nil)
    }
}
