//
//  DetailsViewController.swift
//  FirstSwiftApp
//
//  Created by sumantar on 25/08/14.
//  Copyright (c) 2014 sumantar. All rights reserved.
//

import UIKit
import MediaPlayer
import QuartzCore

class DetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, APIControllerProtocol {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var albumCover: UIImageView!
    
    @IBOutlet weak var tracksTableView: UITableView!
    
    var albumItem: AlbumModel?
    var tracks = [Track]()
    var mediaPlayer: MPMoviePlayerController = MPMoviePlayerController()
    
    lazy var api: APIController = APIController(delegate: self)
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = self.albumItem?.title
        albumCover.image = UIImage(data: NSData(contentsOfURL: NSURL(string: self.albumItem!.largeImageURL)))
        
        if self.albumItem != nil{
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            api.lookupAlbum(self.albumItem!.collectionId)
        }
    }
    
    //UITableview Delegate and DataSource
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return tracks.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!{
        let cell = tableView.dequeueReusableCellWithIdentifier("TrackCell") as TrackCell
        let track = tracks[indexPath.row]
        cell.titleLabel.text = track.title
        cell.playIcon.text = "▶️"
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        var track = tracks[indexPath.row]
        mediaPlayer.stop()
        mediaPlayer.contentURL = NSURL(string: track.previewUrl)
        mediaPlayer.play();
        
        /*
        if let cell = tableView.cellForRowAtIndexPath(indexPath) as? TrackCell {
            cell.playIcon.text = "▶️"
        }*/
    }
    
    func tableView(tableView: UITableView!, willDisplayCell cell: UITableViewCell!, forRowAtIndexPath indexPath: NSIndexPath!) {
        
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1.0)
        UIView.animateWithDuration(0.25) {
            cell.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
        }
    }
    
    //Delegate method implementation
    func didReceiveAPIResults(results: NSDictionary) {
        var result: NSArray = results["results"] as NSArray
        dispatch_async(dispatch_get_main_queue(), {
            self.tracks = Track.tracksWithJSON(result)!
            self.tracksTableView.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }

}
