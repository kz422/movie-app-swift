import Foundation
import Alamofire

final class NetworkManager<T: Codable> {
    static func fetch(from urlString: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        AF.request(urlString).responseDecodable(of: T.self) { (response) in
            if response.error != nil {
                completion(.failure(.invalidResponse))
                print(response.error!)
                return
            }
            
            if let payload = response.value {
                completion(.success(payload))
                return
            }
            
            completion(.failure(.nilResponse))
        }
    }
}

enum NetworkError: Error {
    case invalidResponse
    case nilResponse
}
