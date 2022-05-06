//
//  FavoritesObject.swift
//  Zemoga
//
//  Created by Miguel Angel Saravia Belmonte on 5/5/22.
//

import RealmSwift

final class FavoritesObject: Object {
    @objc dynamic var userObj: userObject = userObject()
    @objc dynamic var postObjt: PostObject = PostObject()
    @objc dynamic var CommentList: [CommentsObject] = []
}

final class userObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var username: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var website: String = ""
}

final class PostObject: Object {
    @objc dynamic var userId: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""
}

final class CommentsObject: Object {
    @objc dynamic var postId: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var body: String = ""
}
