//
//  PersistenceManager.swift
//  floProject2
//
//  Created by Мария  on 5.01.23.
//

import UIKit
enum PersistenceActionType {
    case add,remove
}
enum PersistenceManager {
    static private let defaults =  UserDefaults.standard
    enum Keys {
        static let favorites = "favorites"
    }
    static func updateWith(favorite: Advice, actionType : PersistenceActionType, completed : @escaping(Error?)-> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrivedFavorites =  favorites
            switch actionType {
            case .add:
                guard !retrivedFavorites.contains(favorite) else {
                    completed(nil)
                    return
                }
                retrivedFavorites.append(favorite)
            case .remove:
                retrivedFavorites.removeAll{ $0.title == favorite.title}
            }
               completed(save(favorites: retrivedFavorites))
            case .failure(let failure):
                print("не удалось")
                completed(failure)
            }
        }
    }
    static func save(favorites :[Advice])->Error? {
        do {
            let encoder = JSONEncoder()
            let encodeFavorites = try encoder.encode(favorites)
            defaults.set(encodeFavorites, forKey: Keys.favorites)
            print("successful")
        } catch {
            return nil
        }
        print("not saved")
        return nil
    }
    static func retrieveFavorites(completed : @escaping(Result<[Advice],Error>)-> Void){
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder =  JSONDecoder()
            let favorites = try decoder.decode([Advice].self, from: favoritesData)
            completed(.success(favorites))
        }catch {
            completed(.failure(error))
        }
    }
    static func removeAll(){
        defaults.removeObject(forKey: Keys.favorites)
    }
}
