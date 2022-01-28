//
//  SignUpView.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/10.
//

import UIKit

class SignUpView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        createHeaderView()
        createMainView()
        createFooterView()
    }


    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let navBar: UINavigationBar = {
        let navBar = UINavigationBar(frame: CGRect.zero)

        let navItem = UINavigationItem()
        var img = UIImage(systemName: "xmark",
                          withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .light))
        let navBarCancelButton = UIBarButtonItem(image: img,
                                           style: .done,
                                           target: nil,
                                           action: nil)
        navBarCancelButton.tintColor = .gray

        let logInButton = UIBarButtonItem(title: "Log In", style: .done, target: nil, action: nil)

        navItem.leftBarButtonItem = navBarCancelButton

        let logoImgView = UIImageView(frame: CGRect.zero)
        logoImgView.image = UIImage(named: "Reddit_Mark_OnWhite")
        logoImgView.contentMode = .scaleAspectFill
        navItem.titleView = logoImgView

        navItem.rightBarButtonItem = logInButton

        navBar.items = [navItem]

        // iOS navbar against scrolling
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = .white
        navBar.standardAppearance = appearance
        navBar.scrollEdgeAppearance = navBar.standardAppearance

        return navBar
    }()

    let scrollView = UIScrollView()
    let mainView = UIView()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hi new Friend, welcome to Reddit"
        label.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        label.textColor = .black
        label.numberOfLines = 0

        return label
    }()

    let termsLabel: PaddedLabel = {
        let label = PaddedLabel()
        label.text = """
                By continuing, you agree to our User Agreement and Privacy Policy
                """
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.numberOfLines = 0
        label.paddingLeft = 10
        return label
    }()

    let appleAuthButton: UIButton = {
        let button = UIButton(title: "Continue with Apple",
                              titleColor: UIColor(named: "RedditDarkBlue") ?? .systemPurple,
                              font: .boldSystemFont(ofSize: 18),
                              radius: 20,
                              target: nil,
                              action: nil)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "RedditDarkBlue")?.cgColor
        let img = UIImage(systemName: "applelogo")?
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(.black)
        button.setImage(img, for: .normal)
        button.imageView?.withWidth(20)
        button.contentMode = .scaleAspectFit
        button.imageView?.centerYToSuperview()
        button.imageView?.anchor(.leading(button.leadingAnchor, constant: 20))
        return button
    }()

    let googleAuthButton: UIButton = {
        let button = UIButton(title: "Continue with Google",
                              titleColor: UIColor(named: "RedditDarkBlue") ?? .systemPurple,
                              font: .boldSystemFont(ofSize: 18),
                              radius: 20, target: nil, action: nil)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "RedditDarkBlue")?.cgColor
        let img = UIImage(named: "GoogleLogo")?
            .withRenderingMode(.alwaysOriginal)
        button.setImage(img, for: .normal)
        button.imageView?.withSize(CGSize(width: 20, height: 20))
        button.contentMode = .scaleAspectFit
        button.imageView?.centerYToSuperview()
        button.imageView?.anchor(.leading(button.leadingAnchor, constant: 20))
        return button
    }()

    let centerLine: UIView = {
        let leftLine = UIView().withHeight(1).withWidth(ScreenSize.screenWidth * 0.3)
        let rightLine = UIView().withHeight(1).withWidth(ScreenSize.screenWidth * 0.3)
        leftLine.backgroundColor = .lightGray
        rightLine.backgroundColor = .lightGray

        let centerOr = UILabel()
        centerOr.text = "Or"
        centerOr.textColor = .lightGray
        centerOr.font = UIFont.systemFont(ofSize: 10)
        centerOr.sizeToFit()

        let centerLine = UIView()
        centerLine.addSubview(leftLine)
        centerLine.addSubview(centerOr)
        centerLine.addSubview(rightLine)
        leftLine.anchor(.trailing(centerOr.leadingAnchor, constant: 10))
        leftLine.centerYToSuperview()
        centerOr.centerXToSuperview()
        centerOr.centerYToSuperview()
        rightLine.anchor(.leading(centerOr.trailingAnchor, constant: 10))
        rightLine.centerYToSuperview()

        return centerLine
    }()

    let email = IndentedTextField(placeholder: "Email",
                                  padding: 24,
                                  cornerRadius: 20,
                                  backgroundColor: UIColor(named: "RedditLightGray") ?? .systemGray6)

    let username = IndentedTextField(placeholder: "Username",
                                     padding: 24,
                                     cornerRadius: 20,
                                     backgroundColor: UIColor(named: "RedditLightGray") ?? .systemGray6)

    let password = IndentedTextField(placeholder: "Password",
                                     padding: 24,
                                     cornerRadius: 20,
                                     backgroundColor: UIColor(named: "RedditLightGray") ?? .systemGray6,
                                     isSecureTextEntry: true)


    let formContainerStackView = UIStackView()

    let footerView = UIView()

    lazy var continueButton = GradientButton(title: "Continue",
                                             titleColor: .white, font: .boldSystemFont(ofSize: 18),
                                             backgroundColor: .orange,
                                             radius: 20,
                                             gradientStartColor: .systemPink,
                                             gradientEndColor: .systemOrange)

    private func createFooterView() {
        footerView.addSubview(continueButton)
        footerView.backgroundColor = .white
        footerView.sizeToFit()

        self.addSubview(footerView.withWidth(ScreenSize.screenWidth))
        footerView.anchor(.bottom(self.bottomAnchor, constant: 0), .height(50))
        continueButton.anchor(.leading(self.leadingAnchor, constant: 10),
                              .trailing(self.trailingAnchor, constant: 10), .height(40))
        continueButton.centerInSuperview()
    }

    private func createMainView() {
        self.addSubview(scrollView)
        scrollView.anchor(.top(navBar.bottomAnchor, constant: 0),
                          .height(self.frame.height * 0.8), .width(self.frame.width))

        scrollView.addSubview(mainView)
        print(scrollView.contentSize)

        print(scrollView.isScrollEnabled)

        mainView.anchor(.top(scrollView.topAnchor, constant: 0), .leading(scrollView.leadingAnchor, constant: 10),
                        .trailing(scrollView.trailingAnchor, constant: 10), .bottom(scrollView.bottomAnchor, constant: 0),
                        .height(self.frame.height * 0.8), .width(self.frame.width - 20))
        mainView.centerXToSuperview(constant: 0)
        scrollView.showsVerticalScrollIndicator = true

        let textContainerStackView = UIStackView(arrangedSubviews: [titleLabel.withHeight(70), termsLabel.withHeight(60)])
        textContainerStackView.isLayoutMarginsRelativeArrangement = true
        textContainerStackView.axis = .vertical
        textContainerStackView.alignment = .leading

        mainView.addSubview(textContainerStackView)
        textContainerStackView.anchor(.leading(mainView.leadingAnchor, constant: 0), .trailing(mainView.trailingAnchor, constant: 0))

        let socialAuthContainerStackView = UIStackView(arrangedSubviews: [appleAuthButton.withHeight(40),
                                                                          googleAuthButton.withHeight(40)])
        socialAuthContainerStackView.isLayoutMarginsRelativeArrangement = true
        socialAuthContainerStackView.axis = .vertical
        socialAuthContainerStackView.alignment = .center
        socialAuthContainerStackView.spacing =  5

        mainView.addSubview(socialAuthContainerStackView)
        socialAuthContainerStackView.anchor(.top(textContainerStackView.bottomAnchor, constant: 5),
                                            .leading(mainView.leadingAnchor, constant: 0),
                                            .trailing(mainView.trailingAnchor, constant: 0))
        appleAuthButton.fillSuperviewWidth()
        googleAuthButton.fillSuperviewWidth()

        // Center or line
        mainView.addSubview(centerLine)
        centerLine.anchor(.top(socialAuthContainerStackView.bottomAnchor, constant: 5), .height(50))
        centerLine.fillSuperviewWidth()

        formContainerStackView.addArrangedSubview(email.withHeight(40))
        formContainerStackView.addArrangedSubview(username.withHeight(40))
        formContainerStackView.addArrangedSubview(password.withHeight(40))
        formContainerStackView.isLayoutMarginsRelativeArrangement = true
        formContainerStackView.axis = .vertical
        formContainerStackView.alignment = .center
        formContainerStackView.spacing = 5

        mainView.addSubview(formContainerStackView)
        formContainerStackView.anchor(.top(centerLine.bottomAnchor, constant: 5),
                                      .leading(mainView.leadingAnchor, constant: 0),
                                      .trailing(mainView.trailingAnchor, constant: 0))
        email.anchor(.leading(mainView.leadingAnchor, constant: 0),
                          .trailing(mainView.trailingAnchor, constant: 0))
        username.anchor(.leading(mainView.leadingAnchor, constant: 0),
                          .trailing(mainView.trailingAnchor, constant: 0))
        password.anchor(.leading(mainView.leadingAnchor, constant: 0),
                          .trailing(mainView.trailingAnchor, constant: 0))
    }

    private func createHeaderView() {
        self.addSubview(navBar)
        navBar.backgroundColor = .red
        navBar.sizeToFit()

        navBar.topItem?.titleView?.widthAnchor.constraint(equalToConstant: 70).isActive = true
        if let targetView = navBar.topItem?.titleView {
            NSLayoutConstraint.activateOneWayContraint(targetView: targetView, sizeWay: .width, constant: 70)
        }
        NSLayoutConstraint.activateOneWayContraint(subView: navBar,
                                                   containerViewLayoutGuide: self.safeAreaLayoutGuide,
                                                   way: .top,
                                                   constant: 0)
        NSLayoutConstraint.activateOneWayContraint(subView: navBar, containerView: self, way: .leading, constant: 0)
        NSLayoutConstraint.activateOneWayContraint(subView: navBar, containerView: self, way: .trailing, constant: 0)
    }

}
