//
//  LoginViewController.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 3.05.2025.
//

import UIKit

final class LoginViewController: UIViewController {

    private lazy var viewModel = LoginViewModel(service: AuthService())

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "E-posta"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.layer.borderColor = UIColor.systemIndigo.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Şifre"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.layer.borderColor = UIColor.systemIndigo.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8

        return textField
    }()

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Giriş Yap", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemIndigo
        button.layer.cornerRadius = 8
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()

    
    private let goToSignupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Hesabın yok mu? Kayıt Ol", for: .normal)
        button.setTitleColor(.systemIndigo, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.addTarget(self, action: #selector(goToSignup), for: .touchUpInside)
        return button
    }()

    
    private let imageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "login"))
        iv.contentMode = .scaleAspectFit
        iv.heightAnchor.constraint(equalToConstant: 180).isActive = true
        return iv
    }()

    private let imageDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Beyno İle Ders Çalışmaya Hazır Ol"
        label.textAlignment = .center
        label.textColor = .systemIndigo
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()



    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        bindViewModel()
    }

    private func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [imageView, imageDescriptionLabel, emailTextField, passwordTextField, loginButton, goToSignupButton, statusLabel])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
    private func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }

    private func bindViewModel() {
        viewModel.onLoginSuccess = { token in
            UserDefaults.standard.set(token, forKey: "access_token")
            DispatchQueue.main.async {
                self.navigationController?.setViewControllers([MainTabBarController()], animated: true)
            }
        }

        viewModel.onLoginFailure = { [weak self] message in
                self?.showErrorAlert(title: "Giriş Hatası", message: message)
            }
        
    }

    @objc private func loginButtonTapped() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        viewModel.login(email: email, password: password)
    }

    
    @objc private func goToSignup() {
        let signupVC = SignupViewController()
        navigationController?.pushViewController(signupVC, animated: true)
    }

}
