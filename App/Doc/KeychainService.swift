//
//  KeychainService.swift
//  App
//
//  Created by Эля Корельская on 22.03.2023.
//

import UIKit


struct Credentials {
    let account = "default"
    let password: String
    let serviceName = "UserCredentials"
}

class KeychainSevice {
    // создать элемент связки ключей
    func savePassword(credentials: Credentials) {
        // ключи в словаре
        let query = [
            // ключ для передачи данных элемента
            kSecValueData: Data(credentials.password.utf8),
            // ключ для значений хранимых переменных
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: credentials.serviceName,
            kSecAttrAccount: credentials.account,
        ] as [CFString : Any] as CFDictionary
        let status = SecItemAdd(query, nil)
        print("Operation save password finished with status \(status)")
    }
    // удалить элемент из связки ключей
    func deletePassword(credentials: Credentials) {
        // словаь об удаляемом элементе, который надо найти
        let query = [
            kSecAttrService: credentials.serviceName,
            kSecAttrAccount: credentials.account,
            // ключ для значений хранимых переменных
            kSecClass: kSecClassGenericPassword,
        ] as [CFString : Any] as [CFString : Any] as CFDictionary
        let status = SecItemDelete(query)
        print("Operation delete password finished with status \(status)")
    }
    // повторный ввод пароля
    func retrivePassword(credentials: Credentials) -> (status: OSStatus, data: Data?) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: credentials.account,
            kSecAttrService: credentials.serviceName,
            kSecReturnData: true
        ] as [CFString : Any] as CFDictionary
        var extractedPasswordData: AnyObject?
        // получение элемента
        let status = SecItemCopyMatching(query, &extractedPasswordData)
        if let result = extractedPasswordData as? NSDictionary, let passwordData = result[kSecValueData] as? Data {
            print("Operation retrive password finished with status \(status)")
            print(result)
            let str = String(decoding: passwordData, as: UTF8.self)
            print(str)
        }
        return (status, extractedPasswordData as? Data)
    }
    // обновление пароля
    func updatePassword(credentials: Credentials) {
        // информация об обновляемом элементе
            let query = [
                kSecAttrService: credentials.serviceName,
                kSecAttrAccount: credentials.account,
                kSecClass: kSecClassGenericPassword,
            ] as [CFString : Any] as CFDictionary
        // информация, которую нужно будет заменить
            let attributesToUpdate = [kSecValueData: Data(credentials.password.utf8)] as CFDictionary
            let status = SecItemUpdate(query, attributesToUpdate)
            print("Operation update password finished with status \(status)")
    }
}
