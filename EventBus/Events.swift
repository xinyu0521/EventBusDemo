//
//  Events.swift
//  EventBus
//
//  Created by zhanx630 on 2022/5/22.
//

import Foundation

class Event<T> {
    let identifier: String
    let result: Result<T, Error>?
    init(
        identifier: String,
        result: Result<T, Error>?
    ) {
        self.identifier = identifier
        self.result = result
    }
}

class UserFetchEvent: Event<[User]> {

}
