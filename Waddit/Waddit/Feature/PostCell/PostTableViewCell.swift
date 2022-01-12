import UIKit

struct PostCellData: Codable {
    let id: Int
    let userId: Int
    let userName: String
    let userImageUrl: String
    let title: String
    let text: String
    let images: [String]
    let numUpVotes: Int
    let numDownVotes: Int
    let creadAt: String
}

class PostTableViewCell: UITableViewCell {
    static let identifier = "PostTableViewCell"
    // communtiyStackView
    let communityStackView = UIStackView()
    let communityView = UIView()
    let communityImageView = UIImageView()
    let communityNameLabel = UILabel()
    let userNameLabel = UILabel()
    let createDateLabel = UILabel()
    // postDataView
    let postNameLabel = UIView()
    let postDataView = UILabel()
    let postImageView = UIImageView()
    lazy var leftLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "chevron.right"), for: .normal)
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addCommunityStackView()
        addCommunityView()
        addCommunityImageView()
        addCommunityNameLabel()
        addUserNameLabel()
        addCreateDateLabel()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impl")
    }
    // MARK: - Set stackView that include communityImage, communityName, userName
    func addCommunityStackView() {
        contentView.addSubview(communityStackView)
        communityStackView.translatesAutoresizingMaskIntoConstraints = false
        communityStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        communityStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        communityStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    func addCommunityView() {
        communityStackView.insertArrangedSubview(communityView, at: 0)
    }
    // MARK: - Add CommunityImageView
    func addCommunityImageView() {
        communityView.addSubview(communityImageView)
        communityImageView.image = UIImage(systemName: "star.fill")
        communityImageView.setContentHuggingPriority(.required, for: .horizontal)
        communityImageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        communityImageView.translatesAutoresizingMaskIntoConstraints = false
        communityImageView.topAnchor.constraint(equalTo: communityView.topAnchor, constant: 5).isActive = true
        communityImageView.leadingAnchor.constraint(equalTo: communityView.leadingAnchor, constant: 5).isActive = true
        communityImageView.bottomAnchor.constraint(equalTo: communityView.bottomAnchor, constant: 5).isActive = true
        communityImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        communityImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    // MARK: - Add CommunityNameLabel
    func addCommunityNameLabel() {
        communityView.addSubview(communityNameLabel)
        communityNameLabel.text = "r/CommunityName"
        communityNameLabel.textColor = .systemGray
        communityNameLabel.font = UIFont.systemFont(ofSize: CGFloat(15), weight: .semibold)
        communityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        communityNameLabel.topAnchor.constraint(equalTo: communityView.topAnchor, constant: 6).isActive = true
        communityNameLabel.leadingAnchor.constraint(equalTo: communityImageView.trailingAnchor, constant: 10).isActive = true
    }
    // MARK: - Add CreateDateLabel
    func addUserNameLabel() {
        communityView.addSubview(userNameLabel)
        userNameLabel.text = "username"
        userNameLabel.textColor = .systemGray2
        userNameLabel.font = UIFont.systemFont(ofSize: CGFloat(15))
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.topAnchor.constraint(equalTo: communityNameLabel.bottomAnchor, constant: 2.5).isActive = true
        userNameLabel.leadingAnchor.constraint(equalTo: communityImageView.trailingAnchor, constant: 10).isActive = true
    }
    // MARK: - Add CreateDateLabel
    func addCreateDateLabel() {
        communityView.addSubview(createDateLabel)
        createDateLabel.text = "createDate"
        createDateLabel.textColor = .systemGray2
        createDateLabel.font = UIFont.systemFont(ofSize: CGFloat(15))
        createDateLabel.translatesAutoresizingMaskIntoConstraints = false
        createDateLabel.topAnchor.constraint(equalTo: communityNameLabel.bottomAnchor, constant: 2.5).isActive = true
        createDateLabel.leadingAnchor.constraint(equalTo: userNameLabel.trailingAnchor, constant: 5).isActive = true
    }
    func addpostNameLabel() {
        
    }
    func addPostDataView() {
        
    }
    func addPostImageView() {
        
    }
    func setData() {
    }
}
