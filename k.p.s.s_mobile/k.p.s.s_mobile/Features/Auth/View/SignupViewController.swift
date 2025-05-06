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
    private let imageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "kaydol"))
        iv.contentMode = .scaleAspectFit
        iv.heightAnchor.constraint(equalToConstant: 180).isActive = true
        return iv
    }()

    private let imageDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Yeni bir hesap oluştur!"
        label.textAlignment = .center
        label.textColor = .systemIndigo
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()


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
        nameTextField.layer.borderColor = UIColor.systemIndigo.cgColor
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.cornerRadius = 8


        
        surnameTextField.placeholder = "Soyad"
        surnameTextField.borderStyle = .roundedRect
        surnameTextField.layer.borderColor = UIColor.systemIndigo.cgColor
        surnameTextField.layer.borderWidth = 1
        surnameTextField.layer.cornerRadius = 8


        emailTextField.placeholder = "E-posta"
        emailTextField.borderStyle = .roundedRect
        emailTextField.autocapitalizationType = .none
        emailTextField.layer.borderColor = UIColor.systemIndigo.cgColor
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.cornerRadius = 8


        passwordTextField.placeholder = "Şifre"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.borderColor = UIColor.systemIndigo.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 8


        signupButton.setTitle("Kayıt Ol", for: .normal)
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        signupButton.setTitleColor(.systemIndigo, for: .normal)
        signupButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        

        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 0

        let stack = UIStackView(arrangedSubviews: [imageView, imageDescriptionLabel, nameTextField, surnameTextField, emailTextField, passwordTextField, signupButton, statusLabel])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
          
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

