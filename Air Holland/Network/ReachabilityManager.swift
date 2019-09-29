//
//  Reachability.swift
//  ShowItBig
//
//  Created by Rushi on 09/07/18.
//  Copyright © 2018 Meditab Software Inc. All rights reserved.
//

import Foundation
import Reachability
import MaterialComponents.MaterialSnackbar

/// ReachabilityManager
class ReachabilityManager {
    
    // MARK: - Singleton
    public static let shared = ReachabilityManager()
    
    // MARK: - Properties
    
    let reachability = Reachability()!
    var isReachable: Bool = true
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Initialize
    func initialize() {
        
        // when reachable
        reachability.whenReachable = { status in
            self.isReachable = true
            //self.showInternetConnectionUpdatedMessage()
        }
        
        // when unreachable
        reachability.whenUnreachable = { status in
            self.isReachable = false
            self.showInternetConnectionUpdatedMessage()
        }
        
        // start
        try? reachability.startNotifier()
    }
}

// MARK:- Private
extension ReachabilityManager {
    
    /// Show internet connection updated message
    func showInternetConnectionUpdatedMessage () {
        
        let message = self.isReachable ? InternetConnected : NoInternetConnection
        let snackBarMessage = MDCSnackbarMessage(text: message)
        
        DispatchQueue.main.async {
            MDCSnackbarManager.show(snackBarMessage)
        }
    }
}
