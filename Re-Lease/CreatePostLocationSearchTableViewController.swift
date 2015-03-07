//
//  CreateGroupLocationSearchTableViewController.swift
//  Studies
//
//  Created by Alois Barreras on 1/3/15.
//  Copyright (c) 2015 Alois Barreras. All rights reserved.
//

import UIKit
import MapKit
import AddressBookUI

protocol CreatePostLocationSearchDelegate: class {
    func locationSearchDidSelectPostLocation(postLocation: PostLocation)
    func locationSearchDidCancel()
}

class CreatePostLocationSearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    private let MAP_ITEM_CELL_ID = "MapItemCell"
    
    private var searchBar = UISearchBar()
    
    weak var searchDelegate: CreatePostLocationSearchDelegate!
    private var searchResultsArray: [MKMapItem]?
    private var recentLocationsArray: [MKMapItem]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableHeaderView = self.searchBar
        self.searchBar.delegate = self
        self.searchBar.sizeToFit()
        
        let cellNib = UINib(nibName: "MapItemCell", bundle: nil)
        self.tableView.registerNib(cellNib, forCellReuseIdentifier: "MapItemCell")
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self.searchDelegate, action: Selector("locationSearchDidCancel"))
        self.navigationItem.leftBarButtonItem = cancelButton
    }

    // MARK: - Table View Methods

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows: Int!
        if let count = self.searchResultsArray?.count {
            numberOfRows = count
        } else {
            numberOfRows = 0
        }
        
        return numberOfRows
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        var identifier: String = MAP_ITEM_CELL_ID
        
        cell = tableView.dequeueReusableCellWithIdentifier(identifier) as UITableViewCell
        
        if identifier == MAP_ITEM_CELL_ID {
            let mapItem: MKMapItem = self.searchResultsArray![indexPath.row]
            cell.textLabel?.text = mapItem.name
            let address: String = ABCreateStringWithAddressDictionary(mapItem.placemark.addressDictionary, true)
            let formattedAddress: String = address.stringByReplacingOccurrencesOfString("\n", withString: ", ", options: .CaseInsensitiveSearch, range: nil)
            cell.detailTextLabel?.text = formattedAddress
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String!
        switch section {
        case 0:
            title = nil
        case 1:
            if let searchResults = self.searchResultsArray {
                title = "Locations"
            }
        case 2:
            if self.searchResultsArray == nil {
                title = "Recents"
            }
        default:
            fatalError("Unexpected Index")
        }
        
        return title
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell: UITableViewCell? = tableView.cellForRowAtIndexPath(indexPath)
        let newLocation: PostLocation = PostLocation.object()
        if cell?.reuseIdentifier == MAP_ITEM_CELL_ID {
            let mapItem: MKMapItem = self.searchResultsArray![indexPath.row]
            newLocation.name = mapItem.name
            let placemark: MKPlacemark = mapItem.placemark
            let address: String = ABCreateStringWithAddressDictionary(placemark.addressDictionary, true)
            let formattedAddress: String = address.stringByReplacingOccurrencesOfString("\n", withString: ", ", options: .CaseInsensitiveSearch, range: nil)
            newLocation.address = formattedAddress
            newLocation.location = PFGeoPoint(latitude: placemark.location.coordinate.latitude, longitude: placemark.location.coordinate.longitude)
            self.searchDelegate.locationSearchDidSelectPostLocation(newLocation)
        }
    }
    
    @IBAction func didPressCancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Search Bar Delegate Methods
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.searchResultsArray = nil
            self.tableView.reloadData()
            return
        }
        
        let request: MKLocalSearchRequest = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchText
        
        let search: MKLocalSearch = MKLocalSearch(request: request)
        search.startWithCompletionHandler { (response: MKLocalSearchResponse!, error: NSError!) -> Void in
            if error == nil {
                self.searchResultsArray = response.mapItems as? [MKMapItem]
            }
            self.tableView.reloadData()
        }
    }
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.tableView.endEditing(true)
    }
}
