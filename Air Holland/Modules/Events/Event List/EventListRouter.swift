//
//  EventListRouter.swift
//  Air Holland
//
//  Created by Rahul on 29/09/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

import UIKit
import Foundation

protocol EventRouterDelegate {
    
    func showEventDetail(eventModel: EventModel)
}

class EventListRouter {
    
    fileprivate weak var eventListVC: EventListViewController?

    init(viewController: EventListViewController) {
        eventListVC = viewController
    }
}

extension EventListRouter: EventRouterDelegate {
    
    func showEventDetail(eventModel: EventModel) {
        
        let eventStoryboard = UIStoryboard(name: Storyboard.events, bundle: nil)
        let eventDetailTVC: EventDetailTableViewController?
        
        if #available(iOS 13.0, *) {
            eventDetailTVC = eventStoryboard.instantiateViewController(identifier: String(describing: EventDetailTableViewController.self))
        } else {
            // Fallback on earlier versions
            eventDetailTVC = eventStoryboard.instantiateViewController(withIdentifier: String(describing: EventDetailTableViewController.self)) as? EventDetailTableViewController
        }
        
        eventDetailTVC?.event = eventModel
        eventListVC?.navigationController?.pushViewController(eventDetailTVC!, animated: true)
    }
}
