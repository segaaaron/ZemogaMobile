//
//  PostViewModel.swift
//  Zemoga
//
//  Created by Miguel Angel Saravia Belmonte on 5/4/22.
//

import Foundation


final class PostViewModel {
    
    func serviceCallback<T: Decodable>(with
                                       method: HTTPMethod,
                                       model: T.Type,
                                       endPoint: EndPoints,
                                       params: [String: String] = [:],
                                       completion: @escaping (Result<T, Error>?) -> Void) {
        Service.apiService(with: method, model: model, endPoint: endPoint, params: params, completion: completion)
    }
}
