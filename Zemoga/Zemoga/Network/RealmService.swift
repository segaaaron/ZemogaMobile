//
//  RealmService.swift
//  Zemoga
//
//  Created by Miguel Angel Saravia Belmonte on 5/9/22.
//

import Foundation
import RealmSwift

class RealmService {
    
    private init() {}
    static let shared = RealmService()
    
    var realm = try! Realm()
    
    func createArray<T: Object>(_ object: List<T>){
        do {
            try realm.write({
                realm.add(object)
            })
        } catch {
            post(error)
        }
    }
    
    func delete<T: Object>(_ object: Results<T>, index: Int) {
        do {
            try realm.write({
                realm.delete(object[index])
            })
            
        } catch {
            post(error)
        }
    }
    
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write({
                realm.delete(object)
            })
            
        } catch {
            post(error)
        }
    }
    
    func  post (_ error: Error) {
        NotificationCenter.default.post(name: NSNotification.Name("RealmError"),
                                        object: error,
                                        userInfo: nil)
    }
    
    func observeRealmErrors(in vc: UIViewController, completion: @escaping (Error?) -> Void) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("RealmError"),
                                               object: nil,
                                               queue: nil) { (notification) in
            completion(notification.object as? Error)
        }
    }
    
    func stopObservingError(in vc: UIViewController) {
        NotificationCenter.default.removeObserver(vc, name: NSNotification.Name("RealmError"),
                                                  object: nil)
    }
}
