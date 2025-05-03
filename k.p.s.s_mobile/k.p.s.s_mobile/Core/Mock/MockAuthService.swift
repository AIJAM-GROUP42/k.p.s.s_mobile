import Foundation

final class MockAuthService: AuthServiceProtocol {
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        let user = User(id: 1, name: "Test User", email: email)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.success(user))
        }
    }
    func signup(name: String, email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        let user = User(id: 2, name: name, email: email)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.success(user))
        }
    }

}
