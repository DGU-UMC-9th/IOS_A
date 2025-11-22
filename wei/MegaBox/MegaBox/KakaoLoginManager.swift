import Foundation
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class KakaoLoginManager: ObservableObject {
    static let shared = KakaoLoginManager()
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private init() {}
    
    // MARK: - 카카오 로그인 시작
    func loginWithKakao(
        onSuccess: @escaping (String, String?, KakaoUserInfo) -> Void,
        onFailure: @escaping (Error) -> Void
    ) {
        self.isLoading = true
        
        // 카카오톡 설치 여부 확인
        if UserApi.isKakaoTalkLoginAvailable() {
            // 카카오톡으로 로그인
            loginWithKakaoTalk(onSuccess: onSuccess, onFailure: onFailure)
        } else {
            // 카카오 계정으로 로그인
            loginWithKakaoAccount(onSuccess: onSuccess, onFailure: onFailure)
        }
    }
    
    // MARK: - 카카오톡 앱으로 로그인
    private func loginWithKakaoTalk(
        onSuccess: @escaping (String, String?, KakaoUserInfo) -> Void,
        onFailure: @escaping (Error) -> Void
    ) {
        UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("❌ 카카오톡 로그인 실패: \(error.localizedDescription)")
                self.handleError(error)
                onFailure(error)
                return
            }
            
            guard let token = oauthToken else {
                let error = NSError(domain: "KakaoLogin", code: -1,
                                  userInfo: [NSLocalizedDescriptionKey: "토큰을 받지 못했습니다."])
                self.handleError(error)
                onFailure(error)
                return
            }
            
            print("✅ 카카오톡 로그인 성공")
            print("   Access Token: \(token.accessToken)")
            print("   Expires In: \(token.expiresIn)초")
            
            // 사용자 정보 요청
            self.requestUserInfo(
                accessToken: token.accessToken,
                refreshToken: token.refreshToken,
                onSuccess: onSuccess,
                onFailure: onFailure
            )
        }
    }
    
    // MARK: - 카카오 계정으로 로그인 (웹)
    private func loginWithKakaoAccount(
        onSuccess: @escaping (String, String?, KakaoUserInfo) -> Void,
        onFailure: @escaping (Error) -> Void
    ) {
        UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("❌ 카카오 계정 로그인 실패: \(error.localizedDescription)")
                self.handleError(error)
                onFailure(error)
                return
            }
            
            guard let token = oauthToken else {
                let error = NSError(domain: "KakaoLogin", code: -1,
                                  userInfo: [NSLocalizedDescriptionKey: "토큰을 받지 못했습니다."])
                self.handleError(error)
                onFailure(error)
                return
            }
            
            print("✅ 카카오 계정 로그인 성공")
            print("   Access Token: \(token.accessToken)")
            print("   Expires In: \(token.expiresIn)초")
            
            // 사용자 정보 요청
            self.requestUserInfo(
                accessToken: token.accessToken,
                refreshToken: token.refreshToken,
                onSuccess: onSuccess,
                onFailure: onFailure
            )
        }
    }
    
    // MARK: - 사용자 정보 요청
    private func requestUserInfo(
        accessToken: String,
        refreshToken: String?,
        onSuccess: @escaping (String, String?, KakaoUserInfo) -> Void,
        onFailure: @escaping (Error) -> Void
    ) {
        UserApi.shared.me { [weak self] (user, error) in
            guard let self = self else { return }
            self.isLoading = false
            
            if let error = error {
                print("❌ 사용자 정보 요청 실패: \(error.localizedDescription)")
                self.handleError(error)
                onFailure(error)
                return
            }
            
            guard let user = user else {
                let error = NSError(domain: "KakaoLogin", code: -1,
                                  userInfo: [NSLocalizedDescriptionKey: "사용자 정보를 받지 못했습니다."])
                self.handleError(error)
                onFailure(error)
                return
            }
            
            // LoginViewModel에 정의된 KakaoUserInfo 사용
            let userInfo = KakaoUserInfo(
                id: user.id ?? 0,
                nickname: user.kakaoAccount?.profile?.nickname,
                profileImage: user.kakaoAccount?.profile?.profileImageUrl?.absoluteString,
                email: user.kakaoAccount?.email
            )
            
            print("✅ 카카오 사용자 정보 받음:")
            print("   ID: \(userInfo.id)")
            print("   닉네임: \(userInfo.nickname ?? "없음")")
            print("   이메일: \(userInfo.email ?? "없음")")
            
            onSuccess(accessToken, refreshToken, userInfo)
        }
    }
    
    // MARK: - 로그아웃
    func logout(completion: @escaping (Error?) -> Void) {
        UserApi.shared.logout { error in
            if let error = error {
                print("❌ 카카오 로그아웃 실패: \(error.localizedDescription)")
                completion(error)
            } else {
                print("✅ 카카오 로그아웃 성공")
                completion(nil)
            }
        }
    }
    
    // MARK: - 연결 끊기 (회원 탈퇴)
    func unlink(completion: @escaping (Error?) -> Void) {
        UserApi.shared.unlink { error in
            if let error = error {
                print("❌ 카카오 연결 끊기 실패: \(error.localizedDescription)")
                completion(error)
            } else {
                print("✅ 카카오 연결 끊기 성공")
                completion(nil)
            }
        }
    }
    
    // MARK: - 에러 처리
    private func handleError(_ error: Error) {
        isLoading = false
        errorMessage = error.localizedDescription
        print("❌ 카카오 로그인 에러: \(error)")
    }
}
