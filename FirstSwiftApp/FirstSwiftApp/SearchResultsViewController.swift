//
//  ViewController.swift
//  FirstSwiftApp
//
//  Created by sumantar on 22/08/14.
//  Copyright (c) 2014 sumantar. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, APIControllerProtocol {
    
    let kCellIdentifier: String = "SearchResultCell"
    @IBOutlet weak var tableView: UITableView!
    //var data = []
    var albums = [AlbumModel]()
    
    
    var apiController: APIController?
    
    //Dictionary to keep the image
    var imageCache = [String: UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiController = APIController(delegate: self)
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        //apiController.searchItune("JQ Software")
        //apiController!.searchItune("Angry Birds")
        apiController!.searchItune("Beatles")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //TableView Data Source
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        //return self.data.count;
        return self.albums.count;
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!{

//        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as UITableViewCell
        
//        cell.textLabel.text = "Row # \(indexPath.row)"
//        cell.detailTextLabel.text = "Subtitle # \(indexPath.row)"
        
//        let rowData: NSDictionary = self.albums[indexPath.row] as NSDictionary
//        let cellText:String? = rowData["trackName"] as? String
        
        let album = self.albums[indexPath.row]
        cell.textLabel.text = album.title
        
        cell.imageView.image = UIImage(named: "Blank52")
        // Get the formatted price string for display in the subtitle
        let formattedPrice = album.price
        
        // Grab the artworkUrl60 key to get an image URL for the app's thumbnail
        let urlString = album.thumbnailImageURL
        
        
       // let urlString: NSString = rowData["artworkUrl60"] as NSString
        
        
        var image = self.imageCache[urlString];
        
        if(image == nil){
            
            let imgURL: NSURL = NSURL(string: urlString)
            let request: NSURLRequest = NSURLRequest(URL: imgURL)
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                
                if error == nil {
                    image = UIImage(data: data)
                    
                    // Store the image in to our cache
                    self.imageCache[urlString] = image
                    
//                    dispatch_async(dispatch_get_main_queue(), {
//                        cell.imageView.image = image
//                    })
                    if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) {
                        cellToUpdate.imageView.image = image
                    }
                }
                else {
                    println("Error: \(error.localizedDescription)")
                }
                
            })
        }
        else{
            dispatch_async(dispatch_get_main_queue(), {
                if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) {
                    cellToUpdate.imageView.image = image
                }
            })
        }
        
        //let formattedPrice: NSString = rowData["formattedPrice"] as NSString
        cell.detailTextLabel.text = formattedPrice
        
        return cell
    }
    
    //Implementation of APIController delegate method
    func didReceiveAPIResults(results: NSDictionary){
        
        let resultArray = results["results"] as NSArray
       
        dispatch_async(dispatch_get_main_queue(), {
            //self.data = resultArray
            self.albums = AlbumModel.objectsFromJSONArray(resultArray)
            self.tableView!.reloadData()
            
            //Stop Activity Indicator
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })

    }
    
    /*
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        // Get the row data for the selected row
        let rowData: AlbumModel = self.albums[indexPath.row]
        
        let name: String = rowData.title
        let formattedPrice: String = rowData.price
        
        let alert: UIAlertView = UIAlertView()
        alert.title = name
        alert.message = formattedPrice
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
*/
    
    func tableView(tableView: UITableView!, willDisplayCell cell: UITableViewCell!, forRowAtIndexPath indexPath: NSIndexPath!) {
        
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1.0)
        UIView.animateWithDuration(0.25) {
            cell.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
        }
    }

    
    //Prepare Segue
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        var detailsViewController: DetailsViewController = segue.destinationViewController as DetailsViewController
        let selectedIndex = self.tableView!.indexPathForSelectedRow().row
        detailsViewController.albumItem = self.albums[selectedIndex]
    }
}

