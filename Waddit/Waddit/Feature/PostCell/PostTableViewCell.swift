import UIKit
import Pageboy

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
    let communityView = UIView()
    let communityImageView = UIImageView()
    let communityNameLabel = UILabel()
    let userNameLabel = UILabel()
    let createDateLabel = UILabel()
    let postNameLabel = UILabel()
    let postDataLabel = UILabel()
    let postImageView = UIImageView()
    let upVoteImageView = UIImageView()
    let downVoteImageView = UIImageView()
    let voteLabel = UILabel()
    let commentImageView = UIImageView()
    let commentLabel = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addCommunityView()
        addCommunityImageView()
        addCommunityNameLabel()
        addUserNameLabel()
        addCreateDateLabel()
        addPostNameLabel()
        addPostDataLabel()
        addUpVoteImageView()
        addVoteLabel()
        addDownVoteImageView()
        addCommentLabel()
        addCommentImageView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // MARK: - Set View that include communityImage, communityName, userName
    func addCommunityView() {
        contentView.addSubview(communityView)
        communityView.translatesAutoresizingMaskIntoConstraints = false
        communityView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        communityView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        communityView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        communityView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
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
        communityImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        communityImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    // MARK: - Add CommunityNameLabel
    func addCommunityNameLabel() {
        communityView.addSubview(communityNameLabel)
        communityNameLabel.numberOfLines = 0
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
        userNameLabel.numberOfLines = 0
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
        createDateLabel.numberOfLines = 0
        createDateLabel.text = "createDate"
        createDateLabel.textColor = .systemGray2
        createDateLabel.font = UIFont.systemFont(ofSize: CGFloat(15))
        createDateLabel.translatesAutoresizingMaskIntoConstraints = false
        createDateLabel.topAnchor.constraint(equalTo: communityNameLabel.bottomAnchor, constant: 2.5).isActive = true
        createDateLabel.leadingAnchor.constraint(equalTo: userNameLabel.trailingAnchor, constant: 5).isActive = true
    }
    func addPostNameLabel() {
        communityView.addSubview(postNameLabel)
        postNameLabel.numberOfLines = 0
        postNameLabel.text = "Post Name"
        postNameLabel.font = UIFont.systemFont(ofSize: CGFloat(18), weight: .semibold)
        postNameLabel.translatesAutoresizingMaskIntoConstraints = false
        postNameLabel.topAnchor.constraint(equalTo: communityImageView.bottomAnchor, constant: 5).isActive = true
        postNameLabel.leadingAnchor.constraint(equalTo: communityView.leadingAnchor, constant: 5).isActive = true
        postNameLabel.trailingAnchor.constraint(equalTo: communityView.trailingAnchor, constant: 5).isActive = true
    }
    func addPostDataLabel() {
        communityView.addSubview(postDataLabel)
        postDataLabel.numberOfLines = 0
        postDataLabel.text = "Post Data Post Data Post Data Post Data Post Data Post Data Post Data Post Data Post Data Post Data"
        postDataLabel.textColor = .systemGray
        postDataLabel.translatesAutoresizingMaskIntoConstraints = false
        postDataLabel.topAnchor.constraint(equalTo: postNameLabel.bottomAnchor, constant: 5).isActive = true
        postDataLabel.leadingAnchor.constraint(equalTo: communityView.leadingAnchor, constant: 5).isActive = true
        postDataLabel.trailingAnchor.constraint(equalTo: communityView.trailingAnchor, constant: 5).isActive = true
    }
    func addPostImageView() {
        // TO DO
    }
    func addUpVoteImageView() {
        communityView.addSubview(upVoteImageView)
        let selectedImageOriginal = UIImage(systemName: "arrow.up.square.fill")
        let selectedImage = selectedImageOriginal?.withRenderingMode(.alwaysTemplate)
        upVoteImageView.image = selectedImage
        upVoteImageView.tintColor = .systemGray
        upVoteImageView.translatesAutoresizingMaskIntoConstraints = false
        upVoteImageView.topAnchor.constraint(equalTo: postDataLabel.bottomAnchor, constant: 10).isActive = true
        upVoteImageView.leadingAnchor.constraint(equalTo: communityView.leadingAnchor, constant: 5).isActive = true
        upVoteImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        upVoteImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    func addVoteLabel() {
        communityView.addSubview(voteLabel)
        voteLabel.numberOfLines = 0
        voteLabel.text = "Vote"
        voteLabel.font = UIFont.systemFont(ofSize: CGFloat(20), weight: .semibold)
        voteLabel.textColor = .systemGray
        voteLabel.translatesAutoresizingMaskIntoConstraints = false
        voteLabel.topAnchor.constraint(equalTo: postDataLabel.bottomAnchor, constant: 10).isActive = true
        voteLabel.leadingAnchor.constraint(equalTo: upVoteImageView.trailingAnchor, constant: 7.5).isActive = true
        voteLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    func addDownVoteImageView() {
        communityView.addSubview(downVoteImageView)
        let selectedImageOriginal = UIImage(systemName: "arrow.down.square.fill")
        let selectedImage = selectedImageOriginal?.withRenderingMode(.alwaysTemplate)
        downVoteImageView.image = selectedImage
        downVoteImageView.tintColor = .systemGray
        downVoteImageView.translatesAutoresizingMaskIntoConstraints = false
        downVoteImageView.topAnchor.constraint(equalTo: postDataLabel.bottomAnchor, constant: 10).isActive = true
        downVoteImageView.leadingAnchor.constraint(equalTo: voteLabel.trailingAnchor, constant: 7.5).isActive = true
        downVoteImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        downVoteImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    func addCommentLabel() {
        communityView.addSubview(commentLabel)
        commentLabel.numberOfLines = 0
        commentLabel.text = "Comment"
        commentLabel.font = UIFont.systemFont(ofSize: CGFloat(20), weight: .semibold)
        commentLabel.textColor = .systemGray
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.topAnchor.constraint(equalTo: postDataLabel.bottomAnchor, constant: 10).isActive = true
        commentLabel.trailingAnchor.constraint(equalTo: communityView.trailingAnchor, constant: -5).isActive = true
        voteLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    func addCommentImageView() {
        communityView.addSubview(commentImageView)
        let selectedImageOriginal = UIImage(systemName: "message")
        let selectedImage = selectedImageOriginal?.withRenderingMode(.alwaysTemplate)
        commentImageView.image = selectedImage
        commentImageView.tintColor = .systemGray
        commentImageView.translatesAutoresizingMaskIntoConstraints = false
        commentImageView.topAnchor.constraint(equalTo: postDataLabel.bottomAnchor, constant: 10).isActive = true
        commentImageView.trailingAnchor.constraint(equalTo: commentLabel.leadingAnchor, constant: -5).isActive = true
        commentImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        commentImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        communityView.bottomAnchor.constraint(equalTo: commentImageView.bottomAnchor, constant: 5).isActive = true
    }
    func setData() {
        // TO DO
    }
}
