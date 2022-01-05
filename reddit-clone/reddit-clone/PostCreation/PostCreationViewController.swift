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
    
    @IBOutlet weak var communityBT: UIButton!
    
    @IBOutlet weak var inputTypes: UIStackView!
    @IBOutlet weak var guideBT: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setHeaderView()
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
