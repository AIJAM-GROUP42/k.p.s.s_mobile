//
//  HomeViewController.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 3.05.2025.
//

import UIKit

final class HomeViewController: UIViewController {

    private let viewModel = HomeViewModel(service: MockPromptService())

    // MARK: - UI

    private let scrollView = UIScrollView()
    private let contentView = UIStackView()

    private let promptCardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.1)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemIndigo.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let promptLabel: UILabel = {
        let label = UILabel()
        label.text = "📚 Hangi konu hakkında araştırma yapmak istiyorsun?"
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    private let promptField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Örneğin: Kurtuluş Savaşı"
        tf.borderStyle = .roundedRect
        return tf
    }()

    private let learnButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Öğren", for: .normal)
        btn.backgroundColor = UIColor.systemIndigo
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return btn
    }()

    private let infoTextView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.font = .systemFont(ofSize: 15)
        tv.isHidden = true
        return tv
    }()

    private let memoryCardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = UIColor.systemTeal.withAlphaComponent(0.1)
        view.layer.borderColor = UIColor.systemTeal.cgColor
        view.layer.borderWidth = 1.2
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()

    private let memoryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .italicSystemFont(ofSize: 15)
        label.textColor = .darkGray
        label.text = "🧠 Hafıza Tekniği burada gösterilecek."
        return label
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }

    // MARK: - Binding

    private func bindViewModel() {
        viewModel.onResponseReceived = { [weak self] response in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.promptCardView.isHidden = true
                self.infoTextView.text = response.info
                self.infoTextView.isHidden = false
                self.memoryLabel.text = "🧠 Hafıza Tekniği:\n\n\(response.memoryTip)"
                self.memoryCardView.isHidden = false
            }
        }
    }

    // MARK: - Setup

    private func setupUI() {
        title = "Ana Sayfa"
        view.backgroundColor = .systemBackground

        // ScrollView ve StackView
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.axis = .vertical
        contentView.spacing = 20
        contentView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        // Prompt Card İçeriği
        let promptStack = UIStackView(arrangedSubviews: [promptLabel, promptField, learnButton])
        promptStack.axis = .vertical
        promptStack.spacing = 12

        promptCardView.addSubview(promptStack)
        promptStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            promptStack.topAnchor.constraint(equalTo: promptCardView.topAnchor, constant: 16),
            promptStack.bottomAnchor.constraint(equalTo: promptCardView.bottomAnchor, constant: -16),
            promptStack.leadingAnchor.constraint(equalTo: promptCardView.leadingAnchor, constant: 16),
            promptStack.trailingAnchor.constraint(equalTo: promptCardView.trailingAnchor, constant: -16)
        ])

        memoryCardView.addSubview(memoryLabel)
        memoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            memoryLabel.topAnchor.constraint(equalTo: memoryCardView.topAnchor, constant: 16),
            memoryLabel.bottomAnchor.constraint(equalTo: memoryCardView.bottomAnchor, constant: -16),
            memoryLabel.leadingAnchor.constraint(equalTo: memoryCardView.leadingAnchor, constant: 16),
            memoryLabel.trailingAnchor.constraint(equalTo: memoryCardView.trailingAnchor, constant: -16)
        ])

        // View Hiyerarşisi
        contentView.addArrangedSubview(promptCardView)
        contentView.addArrangedSubview(infoTextView)
        contentView.addArrangedSubview(memoryCardView)

        // Buton Action
        learnButton.addTarget(self, action: #selector(learnButtonTapped), for: .touchUpInside)
    }

    // MARK: - Action

    @objc private func learnButtonTapped() {
        guard let topic = promptField.text, !topic.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        viewModel.sendPrompt(topic)
    }
}
