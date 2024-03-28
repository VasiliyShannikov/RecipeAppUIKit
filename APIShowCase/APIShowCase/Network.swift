//
//  Network.swift
//  APIShowCase
//
//  Created by Vasiliy Shannikov on 25.03.2024.
//

import Foundation

final class Network {
    let baseUrl = "https://www.themealdb.com/api/json/v1/1/"

    func executeRequest<T: Decodable>(request: Request) async throws -> T {
        let url = baseUrl + request.path
        var components = URLComponents(string: url)
        var queryItems = [URLQueryItem]()

        request.params.forEach { key, value in
            queryItems.append(URLQueryItem(name: key, value: value))
        }

        components?.queryItems = queryItems

        guard let finalURL = components?.url else { throw NetworkErrors.urlError }

        let response = try await URLSession.shared.data(from: finalURL)
        let decoder = JSONDecoder()
        let model = try decoder.decode(T.self, from: response.0)

        return model
    }
}
