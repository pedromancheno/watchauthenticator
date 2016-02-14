//
//  WatchAuthenticationController.swift
//  WatchAuthenticator
//
//  Created by Pedro Mancheno on 14/02/16.
//  Copyright © 2016 pedromancheno. All rights reserved.
//

class AuthenticationController {
    
    let connectivityController = ConnectivityController()
  
    func getAuthInfo(completion: (success: Bool, token: String?, error: NSError?) -> Void) {
        connectivityController.requestAuthInfoFromPhone { (success, response, error) -> Void in
            if success {
                let token = response![AuthInfoToken.key] as? String
                completion(success: true, token: token, error: nil)
            } else if error != nil {
                completion(success: false, token: nil, error: error)
            }
        }
    }
}