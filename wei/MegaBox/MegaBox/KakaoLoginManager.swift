//
//  KakaoLoginManager.swift
//  MegaBox
//
//  Created by 이연우 on 11/11/25.
//

import Foundation
import Alamofire
import AuthenticationServices

class KakaoLoginManager: NSObject, ObservableObject {
    static let shared = KakaoLoginManager()
    private var authSession: ASWebAuthenticationSession?
    
    private let clientId: String = {
            guard let key = Bundle.main.object(forInfoDictionaryKey: "KAKAO_APP_KEY") as? String else {
                fatalError("KAKAO_APP_KEY not found in Info.plist")
            }
            return key
        }()
        
        private let redirectUri: String = {
            guard let uri = Bundle.main.object(forInfoDictionaryKey: "YOUR_REDIRECT_URI") as? String else {
                fatalError("YOUR_REDIRECT_URI not found in Info.plist")
            }
            return uri
        }()
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var presentationAnchor: ASPresentationAnchor?
    private var onSuccess: ((String, String?, KakaoUserInfo) -> Void)?
    private var onFailure: ((Error) -> Void)?
    
    // MARK: - 카카오 로그인 시작
    func loginWithKakao(
        presentationAnchor: ASPresentationAnchor,
        onSuccess: @escaping (String, String?, KakaoUserInfo) -> Void,
        onFailure: @escaping (Error) -> Void
    ) {
        self.presentationAnchor = presentationAnchor
        self.onSuccess = onSuccess
        self.onFailure = onFailure
        self.isLoading = true
        
        // 1단계: 인가 코드 받기
        requestAuthorizationCode()
    }
    
    // MARK: - Step 1: 인가 코드 요청
    private func requestAuthorizationCode() {
        let authUrl = "https://kauth.kakao.com/oauth/authorize"
        let params: [String: String] = [
            "client_id": clientId,
            "redirect_uri": redirectUri,
            "response_type": "code"
        ]
        
        guard var components = URLComponents(string: authUrl) else { return }
        components.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = components.url else { return }
        print("인가 코드 요청 URL: \(url.absoluteString)")
        
        
        // ASWebAuthenticationSession을 사용하여 OAuth 진행
        let session = ASWebAuthenticationSession(
            url: url,
            callbackURLScheme: "kakao\(clientId)"
        ) { [weak self] callbackURL, error in
            guard let self = self else { return }
            
            if let error = error {
                print("인가 코드 요청 실패: \(error.localizedDescription)")
                self.handleError(error)
                return
            }
            
            guard let callbackURL = callbackURL else {
                            print("Callback URL이 없습니다")
                            self.handleError(NSError(domain: "KakaoLogin", code: -1, userInfo: [NSLocalizedDescriptionKey: "Callback URL이 없습니다."]))
                            return
                        }
                        
                        print("Callback URL 받음: \(callbackURL.absoluteString)")
            
            guard let code = URLComponents(string: callbackURL.absoluteString)?
                                .queryItems?
                                .first(where: { $0.name == "code" })?
                                .value else {
                            print("인가 코드를 찾을 수 없습니다")
                            self.handleError(NSError(domain: "KakaoLogin", code: -1, userInfo: [NSLocalizedDescriptionKey: "인가 코드를 받지 못했습니다."]))
                            return
                        }
                        
                        print("인가 코드 받음: \(code)")
            
            // 2단계: 토큰 받기
            self.requestAccessToken(code: code)
        }
        
        session.presentationContextProvider = self
        session.prefersEphemeralWebBrowserSession = true
        
        self.authSession = session 
        session.start()
    }
    
    // MARK: - Step 2: 액세스 토큰 요청
    private func requestAccessToken(code: String) {
        let tokenUrl = "https://kauth.kakao.com/oauth/token"
        
        let parameters: [String: String] = [
            "grant_type": "authorization_code",
            "client_id": clientId,
            "redirect_uri": redirectUri,
            "code": code
        ]
        
        AF.request(
            tokenUrl,
            method: .post,
            parameters: parameters,
            encoder: URLEncodedFormParameterEncoder.default
        )
        .validate()
        .responseDecodable(of: KakaoTokenResponse.self) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let tokenResponse):
                // 3단계: 사용자 정보 요청
                print("액세스 토큰 받음")
                print("   Token Type: \(tokenResponse.token_type)")
                print("   Expires In: \(tokenResponse.expires_in)초")
                self.requestUserInfo(accessToken: tokenResponse.access_token, refreshToken: tokenResponse.refresh_token)
                
            case .failure(let error):
                self.handleError(error)
            }
        }
    }
    
    // MARK: - Step 3: 사용자 정보 요청
    private func requestUserInfo(accessToken: String, refreshToken: String?) {
        let userInfoUrl = "https://kapi.kakao.com/v2/user/me"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        AF.request(
            userInfoUrl,
            method: .get,
            headers: headers
        )
        .validate()
        .responseDecodable(of: KakaoUserResponse.self) { [weak self] response in
            guard let self = self else { return }
            self.isLoading = false
            
            switch response.result {
            case .success(let userResponse):
                let userInfo = KakaoUserInfo(
                    id: userResponse.id,
                    nickname: userResponse.properties?.nickname,
                    profileImage: userResponse.properties?.profile_image,
                    email: userResponse.kakao_account?.email
                )
                print(" 카카오 사용자 정보 받음:")
                print("   ID: \(userInfo.id)")
                print("   닉네임: \(userInfo.nickname ?? "없음")")
                print("   이메일: \(userInfo.email ?? "없음")")
                
                self.onSuccess?(accessToken, refreshToken, userInfo)
                print("카카오 사용자 정보: \(userInfo)")
                
            case .failure(let error):
                print("사용자 정보 요청 실패: \(error.localizedDescription)")
                self.handleError(error)
            }
        }
    }
    
    // MARK: - 에러 처리
    private func handleError(_ error: Error) {
        isLoading = false
        errorMessage = error.localizedDescription
        onFailure?(error)
        print("카카오 로그인 에러: \(error)")
    }
}

// MARK: - ASWebAuthenticationPresentationContextProviding
extension KakaoLoginManager: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return presentationAnchor ?? ASPresentationAnchor()
    }
}

// MARK: - Response Models
struct KakaoTokenResponse: Codable {
    let token_type: String
    let access_token: String
    let expires_in: Int
    let refresh_token: String?
    let refresh_token_expires_in: Int?
    let scope: String?
}

struct KakaoUserResponse: Codable {
    let id: Int64
    let properties: KakaoProperties?
    let kakao_account: KakaoAccount?
}

struct KakaoProperties: Codable {
    let nickname: String?
    let profile_image: String?
    let thumbnail_image: String?
}

struct KakaoAccount: Codable {
    let profile: KakaoProfile?
    let email: String?
    let age_range: String?
    let birthday: String?
    let gender: String?
}

struct KakaoProfile: Codable {
    let nickname: String?
    let profile_image_url: String?
    let thumbnail_image_url: String?
}
