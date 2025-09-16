//
//  UserDefaultsManager.swift
//  Simple Contacts List
//
//  Created by Usef on 16/09/2025.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let key = "contacts"
    
    private init() {}
    
    func saveContacts(_ contacts: [Contact]) {
        if let encodedData = try? JSONEncoder().encode(contacts) {
            UserDefaults.standard.set(encodedData, forKey: key)
        }
    }
    
    func loadContacts() -> [Contact] {
        if let decodedData = UserDefaults.standard.data(forKey: key),
           let contacts = try? JSONDecoder().decode([Contact].self, from: decodedData) {
            return contacts
        }
        return []
    }
    
    func saveContact(_ contact: Contact) {
        var contacts = loadContacts()
        contacts.append(contact)
        saveContacts(contacts)
    }
}

extension UserDefaultsManager {
    func removeContact(at index: Int) {
        var contacts = loadContacts()
        if contacts.count > index {
            contacts.remove(at: index)
        }
        saveContacts(contacts)
    }
}
