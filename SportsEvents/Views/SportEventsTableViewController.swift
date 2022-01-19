//
//  SportEventsTableViewController.swift
//  SportsEvents
//
//  Created by Pedro Alcobia on 18/01/2022.
//

import UIKit

class SportEventsTableViewController: UITableViewController {
    
    let sportsRepository = SportEventsRepository()
    var sportList: [SportsCellModel] = [] {
        didSet {
            if Thread.isMainThread {
                self.tableView.reloadData()
            } else {
                DispatchQueue.main.sync {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private var timerUpdateCallbacks: [() -> Void] = []
    private var repeatTimer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tableView.register(SportsTableViewCell.self, forCellReuseIdentifier: "SportsTableViewCell")
        self.tableView.register(UINib(nibName: "SportsTableViewCell", bundle: nil), forCellReuseIdentifier: "SportsTableViewCell")
        
        self.sportsRepository.getSportsEvents(callback: {self.sportList = $0.map(SportsCellModel.init)})
        
        self.repeatTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SportEventsTableViewController.timerHasUpdated), userInfo: nil, repeats: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        self.timerUpdateCallbacks = []
        return self.sportList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SportsTableViewCell", for: indexPath) as? SportsTableViewCell,
              sportList.count > indexPath.row
        else { return UITableViewCell() }
        cell.setup(sportModel: sportList[indexPath.row],
                   hideEventsCallback: {
            if Thread.isMainThread {
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            } else {
                DispatchQueue.main.sync {
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            }
        })
        self.timerUpdateCallbacks.append(cell.timerHasUpdated)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard self.sportList.count > indexPath.row
        else {return 0}
        let topContainerHeight: CGFloat = 30
        let CollectionViewHeight: CGFloat = 120
        
        return self.sportList[indexPath.row].collapsed ? topContainerHeight :
            topContainerHeight + CollectionViewHeight
    }
    
    @objc
    func timerHasUpdated() {
        self.timerUpdateCallbacks.forEach { timerHandler in
            timerHandler()
        }
    }

}
