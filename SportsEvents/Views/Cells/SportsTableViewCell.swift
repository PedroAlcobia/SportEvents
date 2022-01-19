//
//  SportsTableViewCell.swift
//  SportsEvents
//
//  Created by Pedro Alcobia on 18/01/2022.
//

import UIKit

class SportsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleContainer: UIView!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    @IBOutlet weak var toggleImageUp: UIImageView!
    
    private var timerUpdateCallbacks: [() -> Void] = []
    
    private var hideEventsCallback: (() -> ())!
    
    private var titleContainerTagGesture: UITapGestureRecognizer!
    
    private var sportsCellModel: SportsCellModel!
    
    var events: [EventModel] = [] {
        didSet {
            self.reloadTableView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.eventCollectionView.register(UINib(nibName: "EventsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EventsCollectionViewCell")
        self.eventCollectionView.dataSource = self
        self.eventCollectionView.delegate = self
        
        self.titleContainerTagGesture = .init(target: self, action: #selector(SportsTableViewCell.hideEvents))
        self.titleContainer.addGestureRecognizer(self.titleContainerTagGesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(sportModel: SportsCellModel, hideEventsCallback: @escaping () -> ()) {
        self.sportsCellModel = sportModel
        self.events = sportModel.sportsModel.eventList
        self.Title.text = sportModel.sportsModel.sportName
        self.hideEventsCallback = hideEventsCallback
        if sportModel.previousCollapsed != sportModel.collapsed {
            self.toggleImageUp.transform = sportModel.previousCollapsed ? CGAffineTransform(rotationAngle: .pi) : .identity
            UIView.animate(withDuration: 0.5, delay: 0, options: [UIView.AnimationOptions.allowAnimatedContent,.beginFromCurrentState]) {
                self.toggleImageUp.transform = sportModel.collapsed ? CGAffineTransform(rotationAngle: .pi) : .identity
            } completion: { success in
                print("succcess \(success)")
            }
        }
        self.eventCollectionView.isHidden = sportModel.collapsed
    }
    
    func reloadTableView() {
        if Thread.isMainThread {
            self.eventCollectionView.reloadData()
        } else {
            DispatchQueue.main.sync {
                self.eventCollectionView.reloadData()
            }
        }
    }
    
    func toggleFavouriteOnSelect(row: Int) {
        guard events.count > row
        else { return }
        let event = self.events[row]
        event.toggleFavourite()
        self.events = self.events.sorted()
    }
    
    func timerHasUpdated() {
        self.timerUpdateCallbacks.forEach { timerHandler in
            timerHandler()
        }
    }
    
    @objc
    func hideEvents() {
        self.sportsCellModel.collapsed = !self.sportsCellModel.collapsed
        self.hideEventsCallback()
    }
}

extension SportsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.eventCollectionView.dequeueReusableCell(withReuseIdentifier: "EventsCollectionViewCell", for: indexPath) as? EventsCollectionViewCell,
              self.events.count > indexPath.row
        else { return UICollectionViewCell() }
        
        cell.setup(eventModel: self.events[indexPath.row])
        self.timerUpdateCallbacks.append(cell.timerUpdated)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.timerUpdateCallbacks = []
        return self.events.count
    }
}

extension SportsTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.toggleFavouriteOnSelect(row: indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.toggleFavouriteOnSelect(row: indexPath.row)
    }
}
