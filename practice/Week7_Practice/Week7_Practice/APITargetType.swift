import Moya
import Foundation

/// 우리 앱에서 쓰는 공통 TargetType
protocol APITargetType: TargetType { }

extension APITargetType {
    // 공통 baseURL
    var baseURL: URL {
        URL(string: "https://블라블라.com")!   // 여기 실제 서버 주소로 바꿔줘
    }
    
    // 기본 sampleData (stub 쓸 때 필요)
    var sampleData: Data { Data() }
}

