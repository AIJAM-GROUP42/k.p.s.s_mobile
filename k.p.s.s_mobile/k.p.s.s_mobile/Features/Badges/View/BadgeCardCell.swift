import UIKit

final class BadgeCardCell: UITableViewCell {
    static let identifier = "BadgeCardCell"

    private let badgeImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "odul") 
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.widthAnchor.constraint(equalToConstant: 60).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return iv
    }()

    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 16)
        lbl.numberOfLines = 1
        return lbl
    }()

    private let descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14)
        lbl.textColor = .darkGray
        lbl.numberOfLines = 0
        return lbl
    }()

    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 4
        return sv
    }()

    private let cardView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.systemGray6
        v.layer.cornerRadius = 12
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.05
        v.layer.shadowOffset = CGSize(width: 0, height: 2)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)

        let hStack = UIStackView(arrangedSubviews: [badgeImageView, stackView])
        hStack.axis = .horizontal
        hStack.spacing = 12
        hStack.alignment = .center
        hStack.translatesAutoresizingMaskIntoConstraints = false

        cardView.addSubview(hStack)
        contentView.addSubview(cardView)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            hStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            hStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -12),
            hStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            hStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12)
        ])
    }

    func configure(with badge: Badge) {
        titleLabel.text = badge.title
        descriptionLabel.text = badge.description
        badgeImageView.image = UIImage(named: "odul")
    }
}
