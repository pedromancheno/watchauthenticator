//
//  ConnectivityController.swift
//  WatchAuthenticator
//
//  Created by Pedro Mancheno on 14/02/16.
//  Copyright © 2016 pedromancheno. All rights reserved.
//

import WatchConnectivity

class WatchConnectivityController: NSObject, WCSessionDelegate {
    
    private let session: WCSession?
    
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
    
    func requestAuthInfoFromPhone(completion:(success:Bool,
        response:[String: AnyObject]?,
        error:NSError?) -> Void) {
            
            session?.sendMessage(
                [ConnectivityMessageKey : ConnectivityMessageAuthInfoValue],
                replyHandler: { (responseDict) -> Void in
                    completion(success: true, response: responseDict, error: nil)
                }, errorHandler: { (error) -> Void in
                    completion(success: false, response: nil, error: error)
            })
    }
}