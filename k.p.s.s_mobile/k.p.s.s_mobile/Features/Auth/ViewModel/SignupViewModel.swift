//
//  SignupViewModel.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 3.05.2025.
//
import Foundation
final class SignupViewModel {
    private let service: AuthServiceProtocol

    var onSignupSuccess: ((User) -> Void)?
    var onSignupError: ((String) -> Void)?

    init(service: AuthServiceProtocol) {
        self.service = service
    }

    func signup(name: String, email: String, password: String) {
        service.signup(name: name, email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.onSignupSuccess?(user)
                case .failure(let error):
                    self?.onSignupError?(error.localizedDescription)
                }
            }
        }
    }
}
