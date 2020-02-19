//
//  ViewController.swift
//  GetContactSchedule
//
//  Created by Marco Dos Santos on 17/02/2020.
//  Copyright © 2020 Marco Dos Santos. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController {
    
    var viewModel = ViewModel()
    
    var contactStore = CNContactStore()
    
    var contacts = [ContactModel]()

    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.contactStore.requestAccess(for: .contacts) { (success, error) in
            if success{
                print("Auth OK")
                
            }
        }
        self.contacts = viewModel.getContactsData()
        self.tableView.reloadData()

    }
    
    @IBAction func buttonInvite(_ sender: UIButton) {
        self.showSelecteContacts()
    }
    
    func showSelecteContacts() {
        if !self.viewModel.selectedContacts.isEmpty{
            let alert = UIAlertController(title: "Enviarás invitación a: \n  \(self.getSelectedContactsStringForAlert())", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alert.addAction(okAction)
            let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "No has seleccionado a ningún contacto", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alert.addAction(okAction)

            present(alert, animated: true, completion: nil)
        }

    }
    
    func getSelectedContactsStringForAlert() -> String {
        var stringList = ""
        for item in self.viewModel.selectedContacts{
            stringList += "\(item.firstName) \(item.lastName) \n"
        }
        return stringList
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentContact = contacts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell
        let name = "\(currentContact.firstName) \(currentContact.lastName)"
        let number = currentContact.phoneNumber
        
        cell?.labelName.text = name
        cell?.labelNumber.text = number
        cell?.selectionStyle = UITableViewCell.SelectionStyle.none
        
        
        // switch
        let switchView = cell?.switchSelected
        switchView?.setOn(false, animated: true)
        switchView?.tag = indexPath.row
        switchView?.addTarget(self, action: #selector(self.switchChanged(_:)) , for: .valueChanged)
        return cell!
    }
    
    @objc func switchChanged(_ sender: UISwitch) {
        let contact = contacts[sender.tag]

        if sender.isOn{
            self.viewModel.selectedContacts.append(contact)
        } else if !sender.isOn{
            for (index, item) in self.viewModel.selectedContacts.enumerated(){
                if contact.phoneNumber == item.phoneNumber{
                    self.viewModel.selectedContacts.remove(at: index)
                }

            }
        }
        print("Contactos seleccionados:")
        for contact in self.viewModel.selectedContacts{
            print(contact.firstName, contact.lastName)
        }
        print("")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }

    
}

    

