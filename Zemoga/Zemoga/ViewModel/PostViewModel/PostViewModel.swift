//
//  PostViewModel.swift
//  Zemoga
//
//  Created by Miguel Angel Saravia Belmonte on 5/4/22.
//

import Foundation


final class PostViewModel {
    
    func servicePost(completion: @escaping (Result<[PostModel], Error>?) -> Void) {
        Service.apiService(with: .GET, model: [PostModel].self, endPoint: .posts, params: [:]) { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            case .none:
                break
            }
        }
    }
}
