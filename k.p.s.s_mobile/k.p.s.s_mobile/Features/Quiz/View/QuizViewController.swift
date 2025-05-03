//
//  QuizViewController.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 3.05.2025.
//

import UIKit

final class QuizViewController: UIViewController {
    private let promptCardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let promptLabel: UILabel = {
        let label = UILabel()
        label.text = "Bir konu gir, sana quiz hazırlayayım:"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    private let promptTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Örn: Kurtuluş Savaşı"
        tf.borderStyle = .roundedRect
        return tf
    }()

    private let promptButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Quiz Oluştur", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        return btn
    }()

    private let viewModel = QuizViewModel(service: MockQuizService())
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Quiz"
        view.backgroundColor = .white
        setupPromptUI()
        setupTable()
        bindViewModel()
    }

    
    

    private func setupTable() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(QuizQuestionCell.self, forCellReuseIdentifier: QuizQuestionCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // Başta tablo gizli kalsın
        tableView.isHidden = true
    }


    private func setupPromptUI() {
        promptCardView.addSubview(promptLabel)
        promptCardView.addSubview(promptTextField)
        promptCardView.addSubview(promptButton)
        view.addSubview(promptCardView)

        promptLabel.translatesAutoresizingMaskIntoConstraints = false
        promptTextField.translatesAutoresizingMaskIntoConstraints = false
        promptButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            promptCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            promptCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            promptCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            promptLabel.topAnchor.constraint(equalTo: promptCardView.topAnchor, constant: 16),
            promptLabel.leadingAnchor.constraint(equalTo: promptCardView.leadingAnchor, constant: 16),
            promptLabel.trailingAnchor.constraint(equalTo: promptCardView.trailingAnchor, constant: -16),

            promptTextField.topAnchor.constraint(equalTo: promptLabel.bottomAnchor, constant: 12),
            promptTextField.leadingAnchor.constraint(equalTo: promptCardView.leadingAnchor, constant: 16),
            promptTextField.trailingAnchor.constraint(equalTo: promptCardView.trailingAnchor, constant: -16),

            promptButton.topAnchor.constraint(equalTo: promptTextField.bottomAnchor, constant: 16),
            promptButton.bottomAnchor.constraint(equalTo: promptCardView.bottomAnchor, constant: -16),
            promptButton.centerXAnchor.constraint(equalTo: promptCardView.centerXAnchor)
        ])

        promptButton.addTarget(self, action: #selector(promptButtonTapped), for: .touchUpInside)
    }

    @objc private func promptButtonTapped() {
        guard let prompt = promptTextField.text, !prompt.isEmpty else { return }

        // Prompt Card'ı gizle
        UIView.animate(withDuration: 0.3) {
            self.promptCardView.alpha = 0
        }

        // Gerçek servisle entegre edeceksen burada çağır:
        // self.viewModel.loadQuiz(for: prompt)
        self.viewModel.loadQuiz()
    }

    private func bindViewModel() {
        viewModel.onUpdate = { [weak self] in
            self?.tableView.isHidden = false
            self?.tableView.reloadData()
        }
    }

}

extension QuizViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.questions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let question = viewModel.questions[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuizQuestionCell.identifier, for: indexPath) as? QuizQuestionCell else {
            return UITableViewCell()
        }
        cell.configure(with: question)

        cell.onAnswered = { [weak self] selectedAnswer in
            guard let self = self else { return }

            self.viewModel.recordAnswer(
                questionId: question.id,
                selected: selectedAnswer,
                correct: question.correctAnswer
            )

            if self.viewModel.quizFinished() {
                let score = self.viewModel.scoreSummary()
                let message = "✅ Doğru: \(score.correct)\n❌ Yanlış: \(score.wrong)"

                let alert = UIAlertController(title: "Quiz Tamamlandı!", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: .default))

                DispatchQueue.main.async {
                    self.present(alert, animated: true)
                }
                self.viewModel.submitCorrectCount(userId: 1) {
                        print("Doğru cevap sayısı API'ye gönderildi.")
                    }
            }
        }


        return cell
    }


}
