protocol AuthServiceProtocol {
    func login(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void)
    func signup(name: String, surname: String, email: String, password: String, completion: @escaping (Result<String, Error>) -> Void)
}
