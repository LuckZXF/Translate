import Foundation
import CommonCrypto

let appId = "20240306001984851"
let appKey = "EZemOKzsZVW9NOS8eMZM"


public final class TranslateCode {
    private let parmas: [String]
    public init(parmas: [String] = CommandLine.arguments) {
        self.parmas = parmas
    }
    
    public func translate(_ completion: @escaping (String?)->Void) {
        baiduTranslate(text: self.parmas.first ?? "", appId: appId, appKey:appKey) { string in
            
            completion(string)
        }
    }
    
    public func baiduTranslate(text: String, appId: String, appKey: String, completion: @escaping (String?) -> Void) {
        guard text.count > 0 else {
            completion(nil)
            return
        }
        let url = "http://api.fanyi.baidu.com/api/trans/vip/translate"
        
        let salt = Int.random(in: 32768...65536)
        
        let signStr = appId + text + String(salt) + appKey
        let sign = md5(signStr)
        
        var components = URLComponents(string: url)!
        components.queryItems = [
            URLQueryItem(name: "q", value: text),
            URLQueryItem(name: "from", value: "zh"),
            URLQueryItem(name: "to", value: "en"),
            URLQueryItem(name: "appid", value: appId),
            URLQueryItem(name: "salt", value: String(salt)),
            URLQueryItem(name: "sign", value: sign)
        ]
        
        guard let finalURL = components.url else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: finalURL) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                if let result = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let transResult = result["trans_result"] as? [[String: Any]],
                   let firstResult = transResult.first,
                   let translatedText = firstResult["dst"] as? String {
                    completion(translatedText)
                } else {
                    completion(nil)
                }
            } catch {
                completion(nil)
            }
        }
        task.resume()
    }

}

func md5(_ string: String) -> String {
    let length = Int(CC_MD5_DIGEST_LENGTH)
    var digest = [UInt8](repeating: 0, count: length)
    if let data = string.data(using: .utf8) {
        _ = data.withUnsafeBytes { body -> String in
            CC_MD5(body.baseAddress, CC_LONG(data.count), &digest)
            return ""
        }
    }
    return (0..<length).map { String(format: "%02x", digest[$0]) }.joined()
}
