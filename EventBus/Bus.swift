//
//  Bus.swift
//  EventBus
//
//  Created by zhanx630 on 2022/5/22.
//

import Foundation

class Bus {
    static let shared = Bus()
    
    private init() {}
    
    enum EventType {
        case userFetch
    }
    
    struct Subscription<T> {
        let type: EventType
        let queue: DispatchQueue
        let block: (_ event: Event<T>) -> Void
    }
    
    private var subscriptions: [Any] = []
    
    func subscribe<T>(
        _ type: EventType,
        block: @escaping (_ event: Event<T>) -> Void
    ) {
        let new = Subscription(
            type: type,
            queue: .global(),
            block: block
        )
        subscriptions.append(new)
    }
    
    func subscribeOnMain<T>(
        _ type: EventType,
        block: @escaping (Event<T>) -> Void
    ) {
        let new = Subscription(
            type: type,
            queue: .main,
            block: block
        )
        subscriptions.append(new)
    }
    
    func publish<T>(type: EventType, event: Event<T>) {
        subscriptions
            .filter {
                guard let subscriber = $0 as? Subscription<T> else {
                    return false
                }
                
                return subscriber.type == type
            }
            .forEach { subscriber in
                guard let subscriber = subscriber as? Subscription<T> else {
                    return
                }
                subscriber.queue.async {
                    subscriber.block(event)
                }
            }
    }
}
