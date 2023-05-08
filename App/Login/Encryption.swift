//
//  Encryption.swift
//  App
//
//  Created by Эля Корельская on 07.05.2023.
//

import UIKit

class Encryption {
    
    func getKey() -> Data {
        // Identifier keychain
        let keychainIdentifier = "keychainIdentifier"
        let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        // First check in the keychain for an existing key
        var query: [NSString: AnyObject] = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecReturnData: true as AnyObject
        ]

        var dataTypeRef: AnyObject?
        var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
        if status == errSecSuccess {
            print("Ключ был сохранён в Keychain")
            return dataTypeRef as! Data
        }
        // генерируем случайный ключ
        var key = Data(count: 64)
           key.withUnsafeMutableBytes({ (pointer: UnsafeMutableRawBufferPointer) in
               let result = SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)
               assert(result == 0, "Failed to get random bytes")
           })
        // Store the key in the keychain
        query = [
                kSecClass: kSecClassKey,
                kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
                kSecAttrKeySizeInBits: 512 as AnyObject,
                kSecValueData: key as AnyObject
            ]
        status = SecItemAdd(query as CFDictionary, nil)
        assert(status == errSecSuccess, "Не получается сохранить ключ")
        print("Ключ сгенерирован и сохранён в Keychain\(key.base64EncodedString())")
        return key
    }
}

