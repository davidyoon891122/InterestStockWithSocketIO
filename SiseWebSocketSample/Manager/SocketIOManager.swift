//
//  SocketIOManager.swift
//  SiseWebSocketSample
//
//  Created by jiwon Yoon on 2023/01/26.
//

import Foundation
import SocketIO

protocol SocketIOManager: NSObject {
    var socket: SocketIOClient { get }
    func establishConnection()
    func closeConnection()
    func requestComplete(completion: @escaping () -> Void)
}


final class SiseSocketManager: NSObject, SocketIOManager {
    static let shared = SiseSocketManager()
    
    
    private var manager = SocketManager(
        socketURL: URLInfo.currentPriceSise.url,
        config: [.log(false), .compress]
    )
    
    var socket: SocketIOClient
    
    override init() {
        print(URLInfo.currentPriceSise.url.absoluteString)
        self.socket = self.manager.socket(forNamespace: "/sise")
        super.init()
    }
    
    func establishConnection() {
        self.socket.connect()
    }
    
    func closeConnection() {
        self.socket.removeAllHandlers()
        self.socket.disconnect()
    }
    
    func requestSise(code: String) {
        if socket.status == .connected {
            socket.emit("code", code)
        } else {
            print("Connection has failed")
        }
    }
    
    func requestComplete(completion: @escaping () -> Void) {
        socket.on("connectCompletion") { _, _ in
            completion()
        }
    }
}

