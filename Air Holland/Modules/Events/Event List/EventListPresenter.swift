//
//  EventListPresenter.swift
//  Air Holland
//
//  Created by Rahul on 29/09/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

import UIKit

protocol PresenterDelegate {
    func getEventList(isAPICall : Bool)
}

class EventListPresenter: NSObject {

    // MARK: - Private
    fileprivate var eventView: EventView?
    
    init(view: EventView) {
        eventView = view
    }
}

extension EventListPresenter : PresenterDelegate {
    
    func getEventList(isAPICall: Bool = false) {
        
        eventView?.startLoading()
        
        EventService.getEventList(isAPICall: isAPICall, completion: { [weak self] list in
            
            self?.eventView?.finishLoading()
            self?.eventView?.setEvents(list)
        })
    }
}
