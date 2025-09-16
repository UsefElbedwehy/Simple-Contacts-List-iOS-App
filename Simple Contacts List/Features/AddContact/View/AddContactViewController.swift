//
//  AddContactViewController.swift
//  Simple Contacts List
//
//  Created by Usef on 16/09/2025.
//

import UIKit

class AddContactViewController: UIViewController {
    var delegete: ContactDelegete?
    private var doneButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setupTextFields()
    }
}

// MARK: Navigation Bar Setup
extension AddContactViewController {
    private func setUpNavigationBar() {
        makeDoneButton()
        makeCancelButton()
        makeTitle()
    }

    private func makeDoneButton() {
        doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(saveTapped)
        )
        doneButton.isEnabled = false  // Start disabled
        navigationItem.rightBarButtonItem = doneButton
    }

    private func makeCancelButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(cancelTapped)
        )
    }

    private func makeTitle() {
        self.title = "New Contact"
    }
}

// MARK: TextFields Setup
extension AddContactViewController {
    private func setupTextFields() {
        nameTextField.addTarget(
            self,
            action: #selector(textFieldsDidChange),
            for: .editingChanged
        )
        nameTextField.keyboardType = .namePhonePad
        nameTextField.textContentType = .name
        
        phoneTextField.addTarget(
            self,
            action: #selector(textFieldsDidChange),
            for: .editingChanged
        )
        phoneTextField.keyboardType = .phonePad
        phoneTextField.textContentType = .telephoneNumber
    }

    @objc private func textFieldsDidChange() {
        let nameIsNotEmpty = !(nameTextField.text ?? "").isEmpty
        let phoneIsNotEmpty = !(phoneTextField.text ?? "").isEmpty
        doneButton.isEnabled = nameIsNotEmpty && phoneIsNotEmpty
    }
}

// MARK: Actions
extension AddContactViewController {
    @objc private func saveTapped() {
        if let nameText = nameTextField.text,
            let phoneText = phoneTextField.text
        {
            delegete?.addContact(Contact(name: nameText, phone: phoneText))
        }
        dismissView()
    }

    @objc func cancelTapped() {
        dismissView()
    }

    private func dismissView() {
        dismiss(animated: true, completion: nil)
    }
}
