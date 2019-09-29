//
//  EventListViewController.swift
//  Air Holland
//
//  Created by Rahul on 28/09/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol EventView: NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setEvents(_ events: [String: [EventModel]])
    func setEmpty()
}

class EventListViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Private Properties
    fileprivate var eventPresenter: EventListPresenter? = nil
    fileprivate var eventRouter: EventListRouter? = nil

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(EventListViewController.handleRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = .red
        return refreshControl
    }()
    
    var eventTitles: [String] = []
    
    var eventList: [String: [EventModel]] = [String: [EventModel]]() {
        didSet {
            eventTitles = Array(eventList.keys).sorted()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        initialize()
    }
    
    func setupView() {
        
        title = StringConstants.events
        tableView.addSubview(self.refreshControl)
    }
    
    func initialize() {
        
        eventPresenter = EventListPresenter(view: self)
        eventRouter = EventListRouter(viewController: self)
        
        eventPresenter?.getEventList()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        eventPresenter?.getEventList(isAPICall: true)
    }
}

//MARK:- UITableViewDataSource
extension EventListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return eventList.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let eventTitle = self.eventTitles[section]
        if let event = self.eventList[eventTitle] {
            return event.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return eventTitles[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EventListTableViewCell.self)) as! EventListTableViewCell
        let eventTitle = self.eventTitles[indexPath.section]
        cell.setDataForCell(eventModel: eventList[eventTitle]![indexPath.row])
        return cell
    }
}

//MARK:- UITableViewDelegate
extension EventListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let eventTitle = self.eventTitles[indexPath.section]
        eventRouter?.showEventDetail(eventModel: eventList[eventTitle]![indexPath.row])
    }
}

//MARK:- EventView
extension EventListViewController: EventView, ActivityIndicator {
    
    func startLoading() {
        showIndicator()
    }
    
    func finishLoading() {
        hideIndicator()
        refreshControl.endRefreshing()
    }
    
    func setEvents(_ events: [String : [EventModel]]) {
        eventList = events
    }
    
    func setEmpty() {
        
    }
}
