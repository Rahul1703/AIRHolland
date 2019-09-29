//
//  RealmUtility.swift
//  Air Holland
//
//  Created by Rahul on 29/09/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

import Foundation
import RealmSwift

class RealmUtility {
    
    static let shared = RealmUtility()
    
    private let realm: Realm?
    
    private init(){
        realm = try! Realm()
    }
    
    func saveObject<EventModel:Object>(object: EventModel) {
        try! realm?.write {
            realm?.add(object)
        }
    }

    func saveObjects<EventModel:Object>(object: [EventModel]) {
        
        try! realm?.write {
            realm?.add(object)
        }
    }

    func getObjects<EventModel:Object>()->[EventModel] {
        guard let realmResults = realm?.objects(EventModel.self) else { return [] }
        return Array(realmResults)

    }
    
    func getObjects<EventModel:Object>(filter:String)->[EventModel] {
        guard let realmResults = realm?.objects(EventModel.self).filter(filter) else { return [] }
        return Array(realmResults)
    }
    
    func deleteAllObjects(completion: (()->())?) {
        
        try! realm?.write {
            realm?.deleteAll()
            try? realm?.commitWrite()
            completion?()
        }
    }
}
