//
//  ActivityIndicator.swift
//  Air Holland
//
//  Created by Rahul on 29/09/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

import UIKit
import Foundation
import NVActivityIndicatorView

typealias Completion = (() -> ())

protocol ActivityIndicator {
    
    func showIndicator(_ message:String?, stopAfter: Double?, completion:Completion?)
    
    func hideIndicator()
}

extension ActivityIndicator {
    
    private func setIndicatorViewDefaults() {
        
        NVActivityIndicatorView.DEFAULT_TYPE = .ballSpinFadeLoader
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.darkGray.withAlphaComponent(0.7)
        NVActivityIndicatorView.DEFAULT_BLOCKER_SIZE = CGSize(width: 40, height: 40)
        NVActivityIndicatorView.DEFAULT_BLOCKER_MESSAGE_FONT = UIFont.boldSystemFont(ofSize: 17)
    }
    
    func showIndicator(_ message:String? = nil, stopAfter: Double? = 0, completion:Completion? = nil) {

        setIndicatorViewDefaults()
        
        let activityData = ActivityData(message: "")
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        if stopAfter! > 0.0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + stopAfter!) {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                
                // handler
                if let completionHanlder = completion {
                    completionHanlder()
                }
            }
        }
    }
    
    // Hide indicator
    func hideIndicator() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}

