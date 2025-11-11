//
//  KeychainService.swift
//  Megabox
//
//  Created by 송민교 on 11/11/25.
//

import SwiftUI
import Security

class KeychainService{
    static let shared = KeychainService()
    
    private init() {}
    
    @discardableResult
    func savePasswordToKeychain(id: String, password: String) -> OSStatus {
        // 1. 저장할 데이터를 Data 타입으로 변환
        guard let passwordData = password.data(using: .utf8) else {
            return errSecParam
        }
        
        // 2. Keychain Item 딕셔너리 구성
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword, // 저장유형: 일반 비밀번호
            kSecAttrAccount as String: id, // 계정 식별자
            kSecValueData as String: passwordData, // 실제 저장할 데이터
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked // 접근 가능 조건
        ]
        
        // 3. 이미 같은 항목이 있다면 삭제 (중복 방지)
        SecItemDelete(query as CFDictionary)
        
        // 4. 새 항목 추가
        let status = SecItemAdd(query as CFDictionary, nil)
        
        return status
    }
    
    @discardableResult
    func delete(id: String) -> OSStatus {
        // 1. 삭제할 항목을 식별할 쿼리 구성
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword, // 삭제 대상 유형
            kSecAttrAccount as String: id,
        ]
        
        // 2. 항목 삭제 시도
        let status = SecItemDelete(query as CFDictionary)
        
        // 3. 상태 확인 및 출력
        if status == errSecSuccess {
            print("Keychain 삭제성공")
        } else if status == errSecItemNotFound{
            print("Keychain 항목없음")
        } else {
            print("Keychain 삭제 실패 \(status)")
        }
        return status
    }
    
    // 불러오기 (자동 로그인용)
    func loadPasswordFromKeychain(id: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: id,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess,
              let data = item as? Data,
              let password = String(data: data, encoding: .utf8)
        else { return nil }
        
        return password
    }
    
}
