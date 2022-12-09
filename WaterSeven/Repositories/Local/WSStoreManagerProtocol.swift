//
//  WSStoreManagerProtocol.swift
//  WaterSeven
//
//  Created by Nebo on 19.11.2022.
//

import Foundation
import RealmSwift

protocol WSStoreManagerProtocol {
    
    func saveObjects<T>(_ objects: [T]) where T: Object
    func saveObject<T>(_ object: T) where T: Object
    
    func getObjects<T>(_ type: T.Type) -> [T] where T: Object
//    func getObjects<T>(_ type: T.Type, predicate: NSPredicate) -> [T]? where T: Object
//    
//    func updateObjects<T>(_ objects: [T]) throws where T: Object
//    func updateObject<T>(_ object: T) throws where T: Object
//    
//    func removeObjects<T>(_ objects: [T]) where T: Object
//    func removeObject<T>(_ object: T) where T: Object
//    func removeAllObjectsOfType<T>(_ type: T.Type) where T: Object
//    
//    func removeAll()
}
