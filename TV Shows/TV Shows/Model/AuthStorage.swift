//
//  AutoLogin.swift
//  TV Shows
//
//  Created by Infinum Infinum on 30.07.2021..
//

import Foundation

class AuthTempStorage {

    static let storage: AuthTempStorage = AuthTempStorage()
    var authInfo: AuthInfo?
}

class AuthStorage {

    static func tempStore(_ authInfo: AuthInfo?) -> AuthInfo? {
        return authInfo
    }
    
    static func store(_ authInfo: AuthInfo?) {
        let encoder = PropertyListEncoder()
        if let encoded = try? encoder.encode(authInfo) {
            UserDefaults.standard.set(encoded, forKey: "authInfo")
        }
    }
    
    static func load() -> AuthInfo? {
        let decoder = PropertyListDecoder()
        if
            let data = UserDefaults.standard.data(forKey: "authInfo"),
            let decodedAuthInfo = try? decoder.decode(AuthInfo.self, from: data)
        {
            return decodedAuthInfo
        }
        return nil
    }
    
    static func delete() {
        UserDefaults.standard.removeObject(forKey: "authInfo")
    }
}
