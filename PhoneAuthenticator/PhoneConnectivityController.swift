//
//  PhoneConnectivityController.swift
//  WatchAuthenticator
//
//  Created by Pedro Mancheno on 14/02/16.
//  Copyright © 2016 pedromancheno. All rights reserved.
//

import WatchConnectivity

class PhoneConnectivityController: NSObject, WCSessionDelegate {
    
    private let session: WCSession?
    private var token: String?
    
    override init() {
        if WCSession.isSupported() {
            session = WCSession.defaultSession()
        } else {
            session = nil
        }
        super.init()
        session?.delegate = self
        session?.activateSession()
    }
    
    convenience init(token: String) {
        self.init()
        self.token = token
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject],
        replyHandler: ([String : AnyObject]) -> Void) {
            let messageValue = message[ConnectivityMessageKey] as? String
            if messageValue == ConnectivityMessageAuthInfoValue && token != nil {
                replyHandler([AuthInfoTokenKey:token!])
            } else {
                let error = NSError(domain: "com.pedromancheno",
                    code: -1000,
                    userInfo: [NSLocalizedDescriptionKey:"There was an error getting token from phone"])
                
                replyHandler([AuthInfoErrorKey:error])
            }
    }
}