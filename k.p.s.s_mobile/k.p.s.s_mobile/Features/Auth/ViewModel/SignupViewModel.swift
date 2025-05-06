//
//  SignupViewModel.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 3.05.2025.
//
import Foundation

final class SignupViewModel {
    private let service: AuthServiceProtocol

    var onSignupSuccess: (() -> Void)?
    var onSignupFailure: ((String) -> Void)?

    init(service: AuthServiceProtocol) {
        self.service = service
    }

    func signup(name: String, surname: String, email: String, password: String) {
        service.signup(name: name, surname: surname, email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.onSignupSuccess?()
                case .failure(let error):
                    self?.onSignupFailure?("Kayıt başarısız: \(error.localizedDescription)")
                }
            }
        }
    }
}
