import Foundation
import Security

enum KeychainError: Error {
    case duplicateItem
    case unknown(OSStatus)
    case itemNotFound
    case invalidData
}

class KeychainManager {
    static let shared = KeychainManager()
    
    private init() {}
    
    // MARK: - Save
    func save(key: String, value: String) throws {
        guard let data = value.data(using: .utf8) else {
            throw KeychainError.invalidData
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        // 기존 항목 삭제
        SecItemDelete(query as CFDictionary)
        
        // 새 항목 추가
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }
    }
    
    // MARK: - Load
    func load(key: String) throws -> String {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess else {
            throw KeychainError.itemNotFound
        }
        
        guard let data = result as? Data,
              let string = String(data: data, encoding: .utf8) else {
            throw KeychainError.invalidData
        }
        
        return string
    }
    
    // MARK: - Delete
    func delete(key: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.unknown(status)
        }
    }
    
    // MARK: - Convenience Methods
    func saveCredentials(id: String, password: String, name: String) throws {
        try save(key: "user_id", value: id)
        try save(key: "user_password", value: password)
        try save(key: "user_name", value: name)
    }
    
    func loadCredentials() -> (id: String, password: String, name: String)? {
        guard let id = try? load(key: "user_id"),
              let password = try? load(key: "user_password"),
              let name = try? load(key: "user_name") else {
            return nil
        }
        return (id, password, name)
    }
    
    func deleteCredentials() throws {
        try delete(key: "user_id")
        try delete(key: "user_password")
        try delete(key: "user_name")
    }
    
    // 카카오 토큰 저장
    func saveKakaoToken(accessToken: String, refreshToken: String?) throws {
        try save(key: "kakao_access_token", value: accessToken)
        if let refreshToken = refreshToken {
            try save(key: "kakao_refresh_token", value: refreshToken)
        }
    }
    
    func loadKakaoToken() -> (accessToken: String, refreshToken: String?)? {
        guard let accessToken = try? load(key: "kakao_access_token") else {
            return nil
        }
        let refreshToken = try? load(key: "kakao_refresh_token")
        return (accessToken, refreshToken)
    }
    
    func deleteKakaoToken() throws {
        try delete(key: "kakao_access_token")
        try delete(key: "kakao_refresh_token")
    }
}
