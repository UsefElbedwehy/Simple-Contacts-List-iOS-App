//
//  ContactsTableViewController.swift
//  Simple Contacts List
//
//  Created by Usef on 16/09/2025.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    private var viewModel = ContactsViewModel(service: ContactLocalService())
    let contactCellIdentifier = "contactCell"
    private let emptyStateView = EmptyStateView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
        updateEmptyState()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: contactCellIdentifier, for: indexPath) as! ContactsTableViewCell
        cell.configure(with: viewModel.contacts[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteContact(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = viewModel.contacts[indexPath.row].name
        let phone = viewModel.contacts[indexPath.row].phone
        navigateToContactDetails(with: name, and: phone)
    }
}

// MARK: - Naviagtion
extension ContactsTableViewController {
    @objc func presentAddContact() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addContactVC = storyboard.instantiateViewController(withIdentifier: "AddContactViewController") as! AddContactViewController
        
        addContactVC.delegete = self
        let navController = UINavigationController(rootViewController: addContactVC)
        navController.modalPresentationStyle = .pageSheet

        if let sheet = navController.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }

        present(navController, animated: true, completion: nil)
    }
    
    func navigateToContactDetails(with name: String, and phone: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let contactDetailsVC = storyboard.instantiateViewController(withIdentifier: "contactDetailsViewController") as? ContactDetailsViewController else { return }

        contactDetailsVC.name = name
        contactDetailsVC.phone = phone

        navigationController?.pushViewController(contactDetailsVC, animated: true)
    }
}

// MARK: - Setups
extension ContactsTableViewController {
    private func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddContact))
    }
    
    private func setupViewModel() {
        viewModel.didLoadContacts = { [weak self] in
            self?.updateUI()
        }
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.updateEmptyState()
        }
    }

    private func updateEmptyState() {
        tableView.backgroundView = viewModel.contacts.isEmpty ? emptyStateView : nil
    }
}

// MARK: - Contact Delegete
extension ContactsTableViewController: ContactDelegete {
    func addContact(_ contact: Contact) {
        viewModel.addContact(contact)
    }
}
