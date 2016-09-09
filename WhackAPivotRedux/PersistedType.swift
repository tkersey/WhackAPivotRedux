protocol PersistedType {
    func save(string: String, key: PersistedKey)
    func load(key: PersistedKey) -> String?
}
