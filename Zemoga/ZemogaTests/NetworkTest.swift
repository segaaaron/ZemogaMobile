//
//  NetworkTest.swift
//  ZemogaTests
//
//  Created by Miguel Angel Saravia Belmonte on 5/10/22.
//

import XCTest
@testable import Zemoga

class NetworkTest: XCTestCase {
    
    func test_service_with_model() {
        let promise = expectation(description: "Status code: 200")
        var postList: [PostModel] = []
        
        Service.apiService(with: .GET, model: [PostModel].self, endPoint: .posts) { result in
            switch result {
            case .success(let result):
                postList = result
                promise.fulfill()
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            case .none:
                break
            }
        }
        
        wait(for: [promise], timeout: 5)
        XCTAssertEqual(postList.count > 0, true)
    }
    
    func test_service_error_model() {
        let promise = expectation(description: "Status code: 500")
        var list: [UserModel] = []
        
        Service.apiService(with: .GET, model: [UserModel].self, endPoint: .comments(id: 5)) { result in
            switch result {
            case .success(let result):
                list = result
            case .failure(_):
                promise.fulfill()
            case .none:
                break
            }
        }
        
        wait(for: [promise], timeout: 5)
        XCTAssertEqual(list.count > 0, false)
    }
    
    func test_service_error_endpoint() {
        let promise = expectation(description: "Status code: 500")
        var list: [PostModel] = []
        
        Service.apiService(with: .GET, model: [PostModel].self, endPoint: .testpost) { result in
            switch result {
            case .success(let result):
                list = result
            case .failure(_):
                promise.fulfill()
            case .none:
                break
            }
        }
        
        wait(for: [promise], timeout: 5)
        XCTAssertEqual(list.count > 0, false)
    }
    
    func test_service_error_model_params() {
        let promise = expectation(description: "Status code: 500")
        var list: [TestModel] = []
        
        Service.apiService(with: .POST, model: [TestModel].self, endPoint: .comments(id: 2), params: ["info": "test"]) { result in
            switch result {
            case .success(let result):
                list = result
            case .failure(_):
                promise.fulfill()
            case .none:
                break
            }
        }
        
        wait(for: [promise], timeout: 5)
        XCTAssertEqual(list.count > 0, false)
    }
    
    func test_service_method_get_params() {
        let promise = expectation(description: "Status code: 200")
        var list: [PostModel] = []
        
        Service.apiService(with: .GET, model: [PostModel].self, endPoint: .posts, params: ["info": "test"]) { result in
            switch result {
            case .success(let result):
                list = result
                promise.fulfill()
            case .failure(_): break
            case .none:
                break
            }
        }
        
        wait(for: [promise], timeout: 5)
        XCTAssertEqual(list.count > 0, true)
    }
}
