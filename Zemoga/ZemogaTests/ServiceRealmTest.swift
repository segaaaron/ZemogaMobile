//
//  ServiceRealmTest.swift
//  ZemogaTests
//
//  Created by Miguel Angel Saravia Belmonte on 5/10/22.
//

import XCTest
import RealmSwift
@testable import Zemoga

class ServiceRealmTest: XCTestCase {

    let sup = try! Realm()
    
    override func setUp() {
        super.setUp()
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }
    
    func test_create_service() {
        var commentsList: [CommentsModel] = []
        commentsList.append(CommentsModel(postID: 1, id: 0, name: "test", email: "test@gmail.com", body: "test_body"))
        let userObj = UserObject()
        userObj.id = 1
        userObj.name = "test"
        userObj.username = "test.username"
        userObj.email = "test@gmail.com"
        userObj.phone = "123455"
        userObj.website = "www.test.com"
        let postObj = PostObject()
        postObj.userId = 2
        postObj.id = 1
        postObj.title = "test_title"
        postObj.body = "test_body"

        let commentListObj = List<CommentsObject>()
        commentsList.forEach { obj in
            let commentObj = CommentsObject()
            commentObj.postId = obj.postID
            commentObj.id = obj.id
            commentObj.name = obj.name
            commentObj.email = obj.email
            commentObj.body = obj.body
            commentListObj.append(commentObj)
        }

        let favoritesObjc = FavoritesObject()
        favoritesObjc.userObj = userObj
        favoritesObjc.postObjt = postObj
        favoritesObjc.commentList = commentListObj
        let favorites = List<FavoritesObject>()

        favorites.append(favoritesObjc)

        RealmService.shared.createArray(favorites)
        
        let favoriteList = sup.objects(FavoritesObject.self)
        
        XCTAssertEqual(favoriteList.count > 0, true)
    }

}
