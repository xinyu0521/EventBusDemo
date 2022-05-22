//
//  UserListViewModel.swift
//  EventBus
//
//  Created by zhanx630 on 2022/5/22.
//

import Foundation

struct UserListViewModel {
    
    var users: [User] = []
    
    func fetchUserList() {
        let users = [User(name: "Jeff"),
                     User(name: "Karen"),
                     User(name: "Jeo"),
                     User(name: "Matt")]
        let event = UserFetchEvent(identifier: UUID().uuidString,
                                   result: .success(users))
        Bus.shared.publish(type: .userFetch, event: event)
    }
}

struct User {
    let name: String
}
