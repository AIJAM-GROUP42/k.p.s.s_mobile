import Foundation

final class LoginViewModel {
    private let service: AuthServiceProtocol

    var onLoginSuccess: ((User) -> Void)?
    var onLoginError: ((String) -> Void)?

    init(service: AuthServiceProtocol) {
        self.service = service
    }

    func login(email: String, password: String) {
        service.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.onLoginSuccess?(user)
                case .failure(let error):
                    self?.onLoginError?(error.localizedDescription)
                }
            }
        }
    }
}
