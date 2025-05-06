//
//  SignupViewController.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 3.05.2025.
//

import UIKit

final class SignupViewController: UIViewController {

    private let viewModel = SignupViewModel(service: AuthService())

    private let nameTextField = UITextField()
    private let surnameTextField = UITextField()
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
        nameTextField.placeholder = "Ad"
        nameTextField.borderStyle = .roundedRect
        
        surnameTextField.placeholder = "Soyad"
        surnameTextField.borderStyle = .roundedRect

        emailTextField.placeholder = "E-posta"
        emailTextField.borderStyle = .roundedRect
        emailTextField.autocapitalizationType = .none

        passwordTextField.placeholder = "Şifre"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true

        signupButton.setTitle("Kayıt Ol", for: .normal)
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)

        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 0

        let stack = UIStackView(arrangedSubviews: [nameTextField, surnameTextField, emailTextField, passwordTextField, signupButton, statusLabel])
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
        viewModel.onSignupSuccess = { [weak self] in
            let alert = UIAlertController(title: "Başarılı", message: "Kayıt başarılı! Giriş ekranına yönlendiriliyorsunuz.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default) { _ in
                self?.navigationController?.popViewController(animated: true)
            })
            self?.present(alert, animated: true)
        }

        viewModel.onSignupFailure = { [weak self] error in
            self?.statusLabel.text = error
            self?.statusLabel.textColor = .systemRed
        }
    }


    @objc private func signupButtonTapped() {
        viewModel.signup(
            name: nameTextField.text ?? "",
            surname: surnameTextField.text ?? "",
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? ""
        )
    }

}

