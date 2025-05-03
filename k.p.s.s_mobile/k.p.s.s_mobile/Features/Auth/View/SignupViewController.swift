//
//  SignupViewController.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 3.05.2025.
//

import UIKit

final class SignupViewController: UIViewController {

    private let viewModel = SignupViewModel(service: MockAuthService())

    private let nameTextField = UITextField()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let signupButton = UIButton(type: .system)
    private let statusLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Kayıt Ol"
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        nameTextField.placeholder = "Ad Soyad"
        nameTextField.borderStyle = .roundedRect

        emailTextField.placeholder = "E-posta"
        emailTextField.borderStyle = .roundedRect
        emailTextField.autocapitalizationType = .none

        passwordTextField.placeholder = "Şifre"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true

        signupButton.setTitle("Kayıt Ol", for: .normal)
        signupButton.addTarget(self, action: #selector(signupTapped), for: .touchUpInside)

        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 0

        let stack = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField, signupButton, statusLabel])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func bindViewModel() {
        viewModel.onSignupSuccess = { [weak self] user in
            self?.statusLabel.text = "Kayıt başarılı: \(user.name)"
            self?.statusLabel.textColor = .systemGreen
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self?.navigationController?.popViewController(animated: true)
                }
        }

        viewModel.onSignupError = { [weak self] error in
            self?.statusLabel.text = "Hata: \(error)"
            self?.statusLabel.textColor = .systemRed
        }
    }

    @objc private func signupTapped() {
        viewModel.signup(
            name: nameTextField.text ?? "",
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? ""
        )
    }
}
