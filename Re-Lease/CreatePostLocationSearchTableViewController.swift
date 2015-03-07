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
    func locationSearchDidSelectGroupLocation(groupLocation: PostLocation)
}

class CreatePostLocationSearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    private let CURRENT_LOCATION_CELL_ID = "CurrentLocationCell"
    private let MAP_ITEM_CELL_ID = "MapItemCell"
    private let UNKNOWN_LOCATION_CELL_ID = "UnknownLocationCell"
    
    @IBOutlet private var searchBar: UISearchBar!
    
    weak var searchDelegate: CreatePostLocationSearchDelegate!
    private var searchResultsArray: [MKMapItem]?
    private var recentLocationsArray: [MKMapItem]?
    private var currentLocationCellIndexPath: NSIndexPath!
    
    // MARK: - LocationServiceViewController properties
    var currentLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table View Methods

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows: Int!
        switch section {
        case 0:
            numberOfRows = countElements(self.searchBar.text) > 0 ? 2 : 1
        case 1:
            if let count = self.searchResultsArray?.count {
                numberOfRows = count
            } else {
                numberOfRows = 0
            }
        case 2:
            if let count = self.recentLocationsArray?.count {
                numberOfRows = count
            } else {
                numberOfRows = 0
            }
        default:
            fatalError("Unexpected index")
        }
        
        return numberOfRows
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        var identifier: String = MAP_ITEM_CELL_ID
        if indexPath.section == 0 {
            if self.searchBar.text != "" && indexPath.row < 1 {
                identifier = UNKNOWN_LOCATION_CELL_ID
            } else {
                identifier = CURRENT_LOCATION_CELL_ID
                self.currentLocationCellIndexPath = indexPath
            }
        }
        
        cell = tableView.dequeueReusableCellWithIdentifier(identifier) as UITableViewCell
        
        if identifier == MAP_ITEM_CELL_ID {
            let mapItem: MKMapItem = self.searchResultsArray![indexPath.row]
            cell.textLabel?.text = mapItem.name
            let address: String = ABCreateStringWithAddressDictionary(mapItem.placemark.addressDictionary, true)
            let formattedAddress: String = address.stringByReplacingOccurrencesOfString("\n", withString: ", ", options: .CaseInsensitiveSearch, range: nil)
            cell.detailTextLabel?.text = formattedAddress
        } else if identifier == UNKNOWN_LOCATION_CELL_ID {
            cell.textLabel?.text = self.searchBar.text
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
        if cell?.reuseIdentifier == UNKNOWN_LOCATION_CELL_ID {
            newLocation.name = self.searchBar.text
            self.searchDelegate.locationSearchDidSelectGroupLocation(newLocation)
        } else if cell?.reuseIdentifier == CURRENT_LOCATION_CELL_ID {
            if let currentLocation = self.currentLocation {
                let geoCoder: CLGeocoder = CLGeocoder()
                geoCoder.reverseGeocodeLocation(currentLocation, completionHandler: { (objects: [AnyObject]!, error: NSError!) -> Void in
                    if error == nil {
                        let placemark: CLPlacemark = objects[0] as CLPlacemark
                        newLocation.name = placemark.name
                        let address: String = ABCreateStringWithAddressDictionary(placemark.addressDictionary, true)
                        let formattedAddress: String = address.stringByReplacingOccurrencesOfString("\n", withString: ", ", options: .CaseInsensitiveSearch, range: nil)
                        newLocation.address = formattedAddress
                        newLocation.location = PFGeoPoint(latitude: placemark.location.coordinate.latitude, longitude: placemark.location.coordinate.longitude)
                        self.searchDelegate.locationSearchDidSelectGroupLocation(newLocation)
                    }
                })
            }
        } else if cell?.reuseIdentifier == MAP_ITEM_CELL_ID {
            let mapItem: MKMapItem = self.searchResultsArray![indexPath.row]
            newLocation.name = mapItem.name
            let placemark: MKPlacemark = mapItem.placemark
            let address: String = ABCreateStringWithAddressDictionary(placemark.addressDictionary, true)
            let formattedAddress: String = address.stringByReplacingOccurrencesOfString("\n", withString: ", ", options: .CaseInsensitiveSearch, range: nil)
            newLocation.address = formattedAddress
            newLocation.location = PFGeoPoint(latitude: placemark.location.coordinate.latitude, longitude: placemark.location.coordinate.longitude)
            self.searchDelegate.locationSearchDidSelectGroupLocation(newLocation)
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
        
        if let currentLocation = self.currentLocation {
            let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region: MKCoordinateRegion = MKCoordinateRegion(center: currentLocation.coordinate, span: span)
            request.region = region
        }
        
        let search: MKLocalSearch = MKLocalSearch(request: request)
        search.startWithCompletionHandler { (response: MKLocalSearchResponse!, error: NSError!) -> Void in
            if error == nil {
                self.searchResultsArray = response.mapItems as? [MKMapItem]
            }
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Location Service Delegate Methods
    
    func locationManagerDidUpdateLocation(location: CLLocation?) {
        let cell: UITableViewCell? = self.tableView.cellForRowAtIndexPath(self.currentLocationCellIndexPath)
        cell?.textLabel?.text = "Current Location"
    }
    
    func locationManagerDidFailWithError(error: NSError) {
        if error.code == CLError.LocationUnknown.rawValue {
            let cell: UITableViewCell? = self.tableView.cellForRowAtIndexPath(self.currentLocationCellIndexPath)
            cell?.textLabel?.text = "Error Retrieving Location"
        }
    }
}
