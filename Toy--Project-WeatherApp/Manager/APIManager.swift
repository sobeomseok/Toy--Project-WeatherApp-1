//
//  APIManager.swift
//  Toy--Project-WeatherApp
//
//  Created by 민선기 on 2022/01/16.
//

// 37.555985397204545, 126.97129157812294

import Foundation

final class APIManager {
    static let shared = APIManager()
    
    private init () {}
    
    struct Constants {
        static let baseUrl = "https://api.openweathermap.org/data/2.5/"
        static let apiKey = ""
        static let baseLocation = (37.555985397204545, 126.97129157812294)
    }
    
    // MARK: - Public
    /// Search 화면에서 사용 하는 함수
    /// - Parameters:
    ///     - query: 도시 이름 넣으면 그 도시에 대한 날씨 정보 가져옴
    ///     - completion: 콜백 함수
    public func search (
        query: String,
        completion: @escaping (Result<Search, Error>) -> Void
    ) {
        request(
            url: url(
                endpoint: .weather,
                queryParams: [
                    "q" : query
                ]
            ),
            expecting: Search.self,
            completion: completion
        )
    }
    
    /// 요일별 날씨를 가져오는 함수
    public func daily(
        completion: @escaping (Result<Forecast, Error>) -> Void
    ) {
        request(
            url: url(
                endpoint: .forecast,
                queryParams: [
                    "exclude": "\(Exclude.hourly),\(Exclude.minutely)",
                    "lat": "\(Constants.baseLocation.0)",
                    "lon": "\(Constants.baseLocation.1)"
                             ]
            ),
            expecting: Forecast.self,
            completion: completion
        )
    }
    
    // MARK: - Private
    private enum Endpoint: String {
        case weather
        case forecast = "onecall"
    }
    
    private enum Exclude: String {
        case daily
        case hourly
        case minutely
    }
    
    private func url(
        endpoint: Endpoint,
        queryParams: [String: String] = [:]
    ) -> URL? {
        var urlString = Constants.baseUrl + endpoint.rawValue + "?"
        
        var urlQueryItem = [URLQueryItem]()
        
        for (name, value) in queryParams {
            urlQueryItem.append(.init(name: name, value: value))
        }
        
        urlQueryItem.append(.init(name: "appid", value: Constants.apiKey))
        
        urlString += urlQueryItem.map { "\($0.name)=\($0.value ?? "")" }.joined(separator: "&")
        
        return URL(string: urlString)
    }
    
    private func request<T: Codable>(
        url: URL?,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = url else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                
                return
            }
            
            do {
                
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
                
            } catch {
                completion(.failure(error))
            }

        }.resume()
    }
}
