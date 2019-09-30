//
//  EventListPresenter.swift
//  Air Holland
//
//  Created by Rahul on 29/09/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

import UIKit

//MARK:- PresenterDelegate
protocol PresenterDelegate {
    func getEventList(isAPICall : Bool)
}

//MARK:- EventListPresenter
class EventListPresenter: NSObject {

    // MARK: - Private
    fileprivate var eventView: EventView?
    
    init(view: EventView) {
        eventView = view
    }
}

//MARK:- PresenterDelegate
extension EventListPresenter : PresenterDelegate {
    
    /// This method is call by view controller to get data either from API Call or local storage.
    /// - Parameter isAPICall: It will be turn on when pull to refresh is perfrom.
    func getEventList(isAPICall: Bool = false) {
        
        eventView?.startLoading()
        
        //API Call to get data.
        EventService.getEventList(isAPICall: isAPICall, completion: { [weak self] list in
            
            self?.eventView?.finishLoading()
            self?.eventView?.setEvents(list)
        })
    }
}
