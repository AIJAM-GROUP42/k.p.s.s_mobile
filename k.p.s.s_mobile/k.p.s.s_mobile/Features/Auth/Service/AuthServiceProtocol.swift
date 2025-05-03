protocol AuthServiceProtocol {
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func signup(name: String, email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
}
