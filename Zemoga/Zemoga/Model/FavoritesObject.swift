//
//  FavoritesObject.swift
//  Zemoga
//
//  Created by Miguel Angel Saravia Belmonte on 5/5/22.
//

import RealmSwift

class FavoritesObject: Object {
    @objc dynamic var favorite_id = UUID().uuidString
    @objc dynamic var userObj: UserObject?
    @objc dynamic var postObjt: PostObject?
    var commentList = List<CommentsObject>()
    
    override static func primaryKey() -> String? {
        return "favorite_id"
    }
    
    convenience init(userObj: UserObject?, postObjt: PostObject?, commentList: List<CommentsObject>) {
        self.init()
        self.userObj = userObj
        self.postObjt = postObjt
        self.commentList = commentList
    }
}

class UserObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var username: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var website: String = ""
    
    convenience init(id: Int, name: String, username: String, email: String, phone: String, website: String) {
        self.init()
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.phone = phone
        self.website = website
    }
}

class PostObject: Object {
    @objc dynamic var userId: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""
    
    convenience init(userId: Int, id: Int, title: String, body: String) {
        self.init()
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
}

class CommentsObject: Object {
    @objc dynamic var postId: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var body: String = ""
    
    convenience init(postId: Int, id: Int, name: String, email: String, body: String) {
        self.init()
        self.postId = postId
        self.id = id
        self.name = name
        self.email = body
        self.body = body
    }
}
