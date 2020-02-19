//
//  Service.swift
//  GetContactSchedule
//
//  Created by Marco Dos Santos on 18/02/2020.
//  Copyright © 2020 Marco Dos Santos. All rights reserved.
//

import Foundation
import Contacts

class Service {
    var contactStore = CNContactStore()
    var contacts = [ContactModel]()
    
    func getContacts() -> [ContactModel]{
        let key = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: key)
        
        do{
            try contactStore.enumerateContacts(with: request) { (contact, stoppinPointer) in
                    let name = contact.givenName
                    let lastName = contact.familyName
                    let phoneNumber = contact.phoneNumbers.first?.value.stringValue
                    
                let contactToAppend = ContactModel(firstName: name, lastName: lastName, phoneNumber: phoneNumber!)
                    self.contacts.append(contactToAppend)
            }
            
        } catch {
            print(error)
        }
        return contacts
    }

}
