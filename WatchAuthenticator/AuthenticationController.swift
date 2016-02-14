//
//  WatchAuthenticationController.swift
//  WatchAuthenticator
//
//  Created by Pedro Mancheno on 14/02/16.
//  Copyright © 2016 pedromancheno. All rights reserved.
//

class AuthenticationController {
    
    let connectivityController = WatchConnectivityController()
  
    func getAuthInfo(completion: (success: Bool, token: String?, error: NSError?) -> Void) {
        connectivityController.requestAuthInfoFromPhone { (success, response, error) -> Void in
            if success {
                let token = response![AuthInfoTokenKey] as? String
                if token != nil {
                    completion(success: true, token: token, error: nil)
                } else {
                    let error = response![AuthInfoErrorKey] as? NSError
                    if error != nil {
                        completion(success: false, token: nil, error: error)
                    }
                }

            } else if error != nil {
                completion(success: false, token: nil, error: error)
            }
        }
    }
}