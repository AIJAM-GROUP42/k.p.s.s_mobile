import Foundation

final class LoginViewModel {
    
    private let service: AuthServiceProtocol

    var onLoginSuccess: ((String) -> Void)?
    var onLoginFailure: ((String) -> Void)?

    init(service: AuthServiceProtocol) {
        self.service = service
    }

    func login(email: String, password: String) {
        service.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let token):
                    // Token'ı kaydet
                    UserDefaults.standard.set(token, forKey: "access_token")

                    // user_id'yi token içinden çıkar ve kaydet
                    if let userId = self?.extractUserId(from: token) {
                        UserDefaults.standard.set(userId, forKey: "user_id")
                        print("✅ User ID:", userId)
                    }

                    self?.onLoginSuccess?(token)

                case .failure(let error):
                    self?.onLoginFailure?(error.localizedDescription)

                }
            }
        }
    }
    
    private func extractUserId(from token: String) -> Int? {
        let parts = token.split(separator: ".")
        guard parts.count >= 2 else { return nil }

        let payload = parts[1]
        let paddedPayload = payload.padding(toLength: ((payload.count+3)/4)*4, withPad: "=", startingAt: 0)

        guard let data = Data(base64Encoded: paddedPayload),
              let json = try? JSONSerialization.jsonObject(with: data, options: []),
              let dict = json as? [String: Any],
              let sub = dict["sub"] as? String,
              let userId = Int(sub) else {
            return nil
        }

        return userId
    }


}
