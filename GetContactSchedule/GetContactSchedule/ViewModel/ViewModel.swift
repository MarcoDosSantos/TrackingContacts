//
//  ViewModel.swift
//  GetContactSchedule
//
//  Created by Marco Dos Santos on 18/02/2020.
//  Copyright © 2020 Marco Dos Santos. All rights reserved.
//

import Foundation
import Contacts


class ViewModel {
    
//    var contact : ContactModel?
    var service : Service
    var contacts : [ContactModel] = []
    var selectedContacts = [ContactModel]()
    
    
    init() {
        self.service = Service()
    }
    
    func getContactsData() -> [ContactModel] {
        return service.getContacts()
    }

    func getSelectedContacts() -> [ContactModel] {
        return selectedContacts
    }
    
    func setSelectedContactToAppend(contact : ContactModel) {
        self.selectedContacts.append(contact)
    }

}

