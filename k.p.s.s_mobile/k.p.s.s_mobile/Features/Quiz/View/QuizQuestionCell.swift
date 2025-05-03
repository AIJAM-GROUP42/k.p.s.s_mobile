//
//  QuizQuestionCell.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 3.05.2025.
//


import UIKit

final class QuizQuestionCell: UITableViewCell {

    static let identifier = "QuizQuestionCell"

    private let questionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    private var optionButtons: [UIButton] = []
    private var correctAnswer: String = ""

    private let optionsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    var onAnswered: ((String) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        optionsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        optionButtons.removeAll()
    }

    private func setupLayout() {
        let verticalStack = UIStackView(arrangedSubviews: [questionLabel, optionsStack])
        verticalStack.axis = .vertical
        verticalStack.spacing = 12
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(verticalStack)

        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            verticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            verticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            verticalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }

    func configure(with question: QuizQuestion) {
        questionLabel.text = question.question
        correctAnswer = question.correctAnswer

        for option in question.options {
            let button = createStyledButton(title: option)
            button.addTarget(self, action: #selector(optionTapped(_:)), for: .touchUpInside)
            optionButtons.append(button)
            optionsStack.addArrangedSubview(button)
        }
    }

    private func createStyledButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        button.layer.borderWidth = 0
        return button
    }

    @objc private func optionTapped(_ sender: UIButton) {
        guard let answer = sender.titleLabel?.text else { return }


        optionButtons.forEach { $0.isUserInteractionEnabled = false }

        if answer == correctAnswer {
            sender.backgroundColor = .systemGreen
        } else {
            sender.backgroundColor = .systemRed
            if let correctButton = optionButtons.first(where: { $0.titleLabel?.text == correctAnswer }) {
                correctButton.backgroundColor = .systemGreen
            }
        }

        // ViewModel’e sonucu bildir
        onAnswered?(answer)
    }

}
