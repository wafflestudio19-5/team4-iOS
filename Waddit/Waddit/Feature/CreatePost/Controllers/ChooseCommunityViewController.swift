//
//  ChooseCommunityController.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/29.
//

import Foundation
import Alamofire
import UIKit

class ChooseCommunityViewController: UIViewController{

    var pageView: ChooseCommunityView = {
        let rect = UIScreen.main.bounds
        let view = ChooseCommunityView(frame: rect)

        return view
    }()

    var communityList: CommunityList?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = pageView
        self.navigationController?.isNavigationBarHidden = true

        pageView.navBar.topItem?.leftBarButtonItem?.target = self
        pageView.navBar.topItem?.leftBarButtonItem?.action = #selector(didTabCancelButton)
    }

    override func viewWillAppear(_ animated: Bool) {
        let queryDict: [String: Any?] = [UrlParams.lastCommunityId.rawValue: nil,
                         UrlParams.size.rawValue: 10,
                         UrlParams.topicId.rawValue: 0,
                         UrlParams.keyword.rawValue: "News"
        ]

        AF.request(EndPoint.communityList(queryDict: queryDict).url, method: .get, headers: EndPoint.httpHeader).validate().responseDecodable(of: CommunityList.self) { response in

            debugPrint(response)

            switch response.result {
            case .success:
                print(response.value ?? 0)
                self.communityList = response.value
            case .failure(let err):
                print(err)

                let alert = UIAlertController(title: "Error", message: "\(response.response?.statusCode ?? 400)", preferredStyle: .alert)
                let warningAction = UIAlertAction(title: "OK", style: .default)
                alert.addAction(warningAction)

                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }

    @objc
    func didTabCancelButton() {
        if let navVC = self.navigationController {
            navVC.dismiss(animated: true, completion: nil)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}


extension ChooseCommunityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }


}
