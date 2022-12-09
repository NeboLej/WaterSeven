//
//  WSStoreManager.swift
//  WaterSeven
//
//  Created by Nebo on 19.11.2022.
//

import Foundation
import RealmSwift

class WSStoreManager: WSStoreManagerProtocol {
    
    private var realm: Realm?
    
    init() {
        do {
            let config = Realm.Configuration(schemaVersion: 2)
            Realm.Configuration.defaultConfiguration = config
            realm = try Realm()
        } catch {
            print("Error opening Realm: \(error)")
        }
    }
    
    func saveObjects<T>(_ objects: [T]) where T : Object {
        if let realm = realm {
            do {
                try realm.write {
                    realm.add(objects)
                }
            } catch {
                print("Error added to Realm: \(error)")
            }
        }
    }
    
    func saveObject<T>(_ object: T) where T : Object {
        if let realm = realm {
            do {
                try realm.write {
                    realm.add(object)
                }
            } catch {
                print("Error added to Realm: \(error)")
            }
        }
    }
    
    func getObjects<T>(_ type: T.Type) -> [T] where T: Object {
        guard let realm = try? Realm() else { return [] }
        let results = realm.objects(type)
        return Array(results)
    }
//
//    func getObjects<T>(_ type: T.Type, predicate: NSPredicate) -> [T]? where T : Object {
//        <#code#>
//    }
//
//    func updateObjects<T>(_ objects: [T]) throws where T : Object {
//        <#code#>
//    }
//
//    func updateObject<T>(_ object: T) throws where T : Object {
//        <#code#>
//    }
//
//    func removeObjects<T>(_ objects: [T]) where T : Object {
//        <#code#>
//    }
//
//    func removeObject<T>(_ object: T) where T : Object {
//        <#code#>
//    }
//
//    func removeAllObjectsOfType<T>(_ type: T.Type) where T : Object {
//        <#code#>
//    }
//
//    func removeAll() {
//        <#code#>
//    }
}
