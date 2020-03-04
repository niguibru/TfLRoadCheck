//
//  ServiceLayer.swift
//  TfL Coding Challenge
//
//  Created by Nicolas Brucchieri on 03/03/2020.
//  Copyright © 2020 Nicolas Brucchieri. All rights reserved.
//

import Foundation

struct ServiceLayer {

    static func request<T: Codable>(
        router: RequestBuilder,
        completion: @escaping (Result<T, Error>) -> ()
    ) {
        
        guard let urlRequest = router.urlRequest else {
            completion(.failure(CustomError.unknown))
            return
        }
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in

            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                if httpResponse.statusCode == 404, let data = data, let error = try? JSONDecoder().decode(ErrorModel.self, from: data) {
                    DispatchQueue.main.async {
                        completion(.failure(CustomError.notFound(message: error.message)))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(CustomError.unknown))
                    }
                }
                return
            }
                        
            guard let data = data, let responseObject = try? JSONDecoder().decode(T.self, from: data) else {
                DispatchQueue.main.async {
                    completion(.failure(CustomError.parse))
                }
                return
            }

            DispatchQueue.main.async {
                completion(.success(responseObject))
            }
        }
        dataTask.resume()
    }
    
}
