//
//  ContactLocalService.swift
//  Simple Contacts List
//
//  Created by Usef on 16/09/2025.
//

import Foundation

final class ContactLocalService: ContactServiceProtocol {
    func getAllContacts() -> [Contact] {
        UserDefaultsManager.shared.loadContacts()
    }
    
    func addContactFrom(_ name: String, and phone: String) {
        let contact = Contact(name: name, phone: phone)
        UserDefaultsManager.shared.saveContact(contact)
    }
    
    func deleteContact(at index: Int) {
        UserDefaultsManager.shared.removeContact(at: index)
    }
}
