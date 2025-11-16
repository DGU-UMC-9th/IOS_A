//
//  ContentViewModel.swift
//  APIManager
//
//  Created by 백지은 on 11/16/25.
//

import Foundation
import Moya

@Observable
class ContentViewModel {
    
    var userData: UserData?
    let provider: MoyaProvider<UserRotuer>
    let authProvider: MoyaProvider<AuthRouter>
    
    init(provider: MoyaProvider<UserRotuer>, authProvider: MoyaProvider<AuthRouter>) {
        self.provider = provider
        self.authProvider = authProvider
    }
    
    /// 메인 액터 보장
    @MainActor
    convenience init() {
        self.init(
            provider: APIManager.shared.createProvider(for: UserRotuer.self),
            authProvider: APIManager.shared.createProvider(for: AuthRouter.self)
        )
    }
    
    // -----------------------------
    // MARK: - Auth
    // -----------------------------
    func login(username: String, password: String) async {
        let request = LoginRequest(username: username, password: password)
        do {
            let response = try await authProvider.requestAsync(.login(request: request))
            let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: response.data)
            
            let tokenProvider = TokenProvider()
            tokenProvider.accessToken = tokenResponse.accessToken
            tokenProvider.refreshToken = tokenResponse.refreshToken
            
            print("로그인 성공:", tokenResponse)
        } catch {
            print("로그인 실패:", error.localizedDescription)
        }
    }
    
    func logout() async {
        let tokenProvider = TokenProvider()
        guard let refreshToken = tokenProvider.refreshToken else {
            print("리프레시 토큰이 없습니다.")
            return
        }
        
        let request = RefreshTokenRequest(refreshToken: refreshToken)
        do {
            let response = try await authProvider.requestAsync(.logout(request: request))
            if let message = String(data: response.data, encoding: .utf8) {
                print("로그아웃 성공: \(message)")
            }
            
            // 토큰 삭제
            tokenProvider.accessToken = nil
            tokenProvider.refreshToken = nil
            
            await MainActor.run {
                self.userData = nil
            }
        } catch {
            print("로그아웃 실패:", error.localizedDescription)
        }
    }
    
    // -----------------------------
    // MARK: - GET
    // -----------------------------
    func getUser(name: String) async {
        do {
            let response = try await provider.requestAsync(.getPerson(name: name))
            let user = try JSONDecoder().decode(UserData.self, from: response.data)
            
            await MainActor.run {
                self.userData = user
            }
            
            print("GET 성공:", user)
        } catch {
            print("GET 실패:", error.localizedDescription)
        }
    }
    
    func getMyInfo() async {
        do {
            let response = try await provider.requestAsync(.getMyInfo)
            let user = try JSONDecoder().decode(UserData.self, from: response.data)
            
            await MainActor.run {
                self.userData = user
            }
            
            print("GET My Info 성공:", user)
        } catch {
            print("GET My Info 실패:", error.localizedDescription)
        }
    }
    
    // -----------------------------
    // MARK: - POST
    // -----------------------------
    func createUser(_ userData: UserData) {
        provider.request(.postPerson(userData: userData)) { result in
            switch result {
            case .success(let response):
                print("POST 성공: \(response.statusCode)")
            case .failure(let error):
                print("POST 실패:", error)
            }
        }
    }
    
    // -----------------------------
    // MARK: - PATCH (userId 필요)
    // -----------------------------
    func updateUserPatch(userId: Int, patchData: UserPatchRequest) {
        provider.request(.patchPerson(userId: userId, patchData: patchData)) { result in
            switch result {
            case .success(let response):
                print("PATCH 성공: \(response.statusCode)")
            case .failure(let error):
                print("PATCH 실패:", error)
            }
        }
    }
    
    // -----------------------------
    // MARK: - PUT (userId 필요)
    // -----------------------------
    func updateUserPut(userId: Int, userData: UserData) {
        provider.request(.putPerson(userId: userId, userData: userData)) { result in
            switch result {
            case .success(let response):
                print("PUT 성공: \(response.statusCode)")
            case .failure(let error):
                print("PUT 실패:", error)
            }
        }
    }
    
    // -----------------------------
    // MARK: - DELETE (userId 필요)
    // -----------------------------
    func deleteUser(userId: Int) {
        provider.request(.deletePerson(userId: userId)) { result in
            switch result {
            case .success(let response):
                print("DELETE 성공: \(response.statusCode)")
            case .failure(let error):
                print("DELETE 실패:", error)
            }
        }
    }
}

extension MoyaProvider {
    // async/await 지원
    func requestAsync(_ target: Target) async throws -> Response {
        try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
