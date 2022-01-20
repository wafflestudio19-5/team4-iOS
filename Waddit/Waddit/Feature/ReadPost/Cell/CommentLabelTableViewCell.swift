import UIKit

class CommentLabelTableViewCell: UITableViewCell {
    static let identifier = "CommentLabelTableViewCell"
    let commentLabel = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCommentLabel()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // MARK: - Set commentLabel
    func setCommentLabel() {
        contentView.addSubview(commentLabel)
        commentLabel.text = "  Comment"
        commentLabel.textColor = .systemGray
        commentLabel.font = UIFont.systemFont(ofSize: CGFloat(20), weight: .semibold)
        commentLabel.backgroundColor = .systemGray6
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        commentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        commentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        commentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
