//
//  ContactsViewModel.swift
//  Simple Contacts List
//
//  Created by Usef on 16/09/2025.
//

import Foundation

final class ContactsViewModel {
    var contacts: [Contact] = []
    private let service: ContactServiceProtocol

    private var isLoading: Bool = false
    let numberOfSections: Int = 1

    var didLoadContacts: (() -> Void)?

    init(service: ContactServiceProtocol) {
        self.service = service
        loadContacts()
    }

    func addContact(_ contact: Contact) {
        contacts.append(contact)
        service.addContactFrom(contact.name, and: contact.phone)
        didLoadContacts?()
    }

    func loadContacts() {
        isLoading = true
        contacts = service.getAllContacts()
        isLoading = false
        didLoadContacts?()
    }

    func deleteContact(at index: Int) {
        contacts.remove(at: index)
        service.deleteContact(at: index)
        didLoadContacts?()
    }
}
