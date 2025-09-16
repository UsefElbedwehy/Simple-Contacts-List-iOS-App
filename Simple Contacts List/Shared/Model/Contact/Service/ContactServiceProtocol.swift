//
//  ContactServiceProtocol.swift
//  Simple Contacts List
//
//  Created by Usef on 16/09/2025.
//

import Foundation

protocol ContactServiceProtocol {
    func addContactFrom(_ name: String, and phone: String)
    func getAllContacts() -> [Contact]
    func deleteContact(at index: Int)
}
