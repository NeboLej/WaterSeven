//
//  RealmManager.swift
//  WaterSeven
//
//  Created by Nebo on 18.11.2022.
//

import Foundation
import RealmSwift
import Combine

class RealmManager: ObservableObject {
    
    private(set) var localRealm: Realm?
    var tmpModels1: Published<[TmpModel]>
    let tmpModelsPublisher = CurrentValueSubject<[TmpModel], Never>([])
    @Published var tmpModels: [TmpModel] = []
    
    init() {
        tmpModels1 = Published(initialValue: [])
        
        openRealm()
        getTmpModels()
    }
    
    func openRealm() {
        do {
            let configuration = Realm.Configuration(schemaVersion: 2)
            
            Realm.Configuration.defaultConfiguration = configuration
            
            localRealm = try Realm()
            
        } catch {
            print("Error opening Realm: \(error)")
        }
    }
    
    func addTmpModel(text: String) {
        if let localRealm = localRealm {
            do {
                let newModel = TmpModel(value: ["title": text, "completed": false, "list": ["один", "два"] ])
                
                try localRealm.write {
                    localRealm.add(newModel)
                }
                getTmpModels()
            } catch {
                print("Error added to Realm: \(error)")
            }
        }
    }
    
    func getTmpModels() {
        if let localRealm = localRealm {
            let allModels = localRealm.objects(TmpModel.self).sorted(byKeyPath: "completed")
            tmpModels = []
            
            allModels.forEach { tmpModels.append($0) }
            tmpModelsPublisher.send(Array(allModels))
//            let dd = tmpModels1.projectedValue.append(Array(allModels))
        }
    }
    
    func updateTmpModel(id: ObjectId, completed: Bool) {
        if let localRealm = localRealm {
            do {
                let updateModels = localRealm.objects(TmpModel.self).filter(NSPredicate(format: "id == %@", id))
                guard !updateModels.isEmpty else { return }
                
                try localRealm.write {
                    updateModels[0].completed = completed
                    getTmpModels()
                }
            } catch {
                print("Error updating model id \(id) to Realm:\(error)")
            }
        }
    }
    
    func deleteModel(id: ObjectId) {
        if let localRealm = localRealm {
            do {
                let deletedModels = localRealm.objects(TmpModel.self).filter(NSPredicate(format: "id == %@", id))
                guard !deletedModels.isEmpty else { return }
                
                try localRealm.write {
                    localRealm.delete(deletedModels)
                    getTmpModels()
                }
            } catch {
                print("Error deleting model id \(id) to Realm:\(error)")
            }
        }
    }
}


class TmpModel: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title = ""
    @Persisted var completed = false
    @Persisted var list: List<String> = List<String>()
}
