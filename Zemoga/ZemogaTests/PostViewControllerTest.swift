//
//  PostViewControllerTest.swift
//  ZemogaTests
//
//  Created by Miguel Angel Saravia Belmonte on 5/10/22.
//

import XCTest
import RealmSwift
@testable import Zemoga

class PostViewControllerTest: XCTestCase {
    
    var sut: PostViewController!
    
    override func setUpWithError() throws {
        let viewMo = PostViewModel()
        sut = PostViewController(viewModel: viewMo)
        sut.loadViewIfNeeded()
    }
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_main_load(){
        let postList: [PostModel] = [PostModel(userID: 0, id: 0, title: "test_title", body: "test_body")]
        
        sut.postList = postList
        
        _ = sut.view
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(sut.postList.count > 0, true)
    }
}
