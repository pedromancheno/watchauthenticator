//
//  ConnectivityController.swift
//  WatchAuthenticator
//
//  Created by Pedro Mancheno on 14/02/16.
//  Copyright © 2016 pedromancheno. All rights reserved.
//

import WatchConnectivity

class ConnectivityController: NSObject, WCSessionDelegate {
    
    private lazy var session: WCSession? = {
        if WCSession.isSupported() {
            let session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
            return session
        }
        return nil
    }()
    
    func requestAuthInfoFromPhone(completion:(success:Bool,
        response:[String: AnyObject]?,
        error:NSError?) -> Void) {
            
            session?.sendMessage(
                [RequestAuthInfoMessage.key : RequestAuthInfoMessage.value],
                replyHandler: { (responseDict) -> Void in
                    completion(success: true, response: responseDict, error: nil)
                }, errorHandler: { (error) -> Void in
                    completion(success: false, response: nil, error: error)
            })
    }
}