//
//  APIController.swift
//  FirstSwiftApp
//
//  Created by sumantar on 24/08/14.
//  Copyright (c) 2014 sumantar. All rights reserved.
//

import Foundation

class APIController{
    
    var delegate:APIControllerProtocol
    
    init(delegate:APIControllerProtocol){
        self.delegate = delegate
    }
    
    //API Request
    func searchItune(searchItem: String){
        // replace spaces with + signs
        let itunesSearchTerm = searchItem.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        //Now lets URLEncoding to convert string to URL. Use the closure to fetch HTTP Request
        if let escapedSearchItem = itunesSearchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding){
            //iTunes URL for HTTP Request
            //let urlPath = "http://itunes.apple.com/search?term=\(escapedSearchItem)&media=software"
            //This will be useful to search - "JQ Software" or "Angry Birds"
            
            let urlPath = "http://itunes.apple.com/search?term=\(escapedSearchItem)&media=music&entity=album"
            
            httpGetRequest(urlPath)
            
        }
        
    }
    
    func lookupAlbum(collectionId: Int){
        httpGetRequest("https://itunes.apple.com/lookup?id=\(collectionId)&entity=song")
    }
    
    
    func httpGetRequest(path: String){
        
        let url: NSURL = NSURL(string: path)
        
        //Create a session object
        let session = NSURLSession.sharedSession()
        
        //Create a task for session
        let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            println("Task Completed")
            if(error != nil){
                println(error.localizedDescription)
            }
            
            var err: NSError?
            
            var JSONResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            
            if(err != nil) {
                // parsing error
                println("JSON Error \(err!.localizedDescription)")
                return
            }
            
            //println("results: \(JSONResult)")
            self.delegate.didReceiveAPIResults(JSONResult)
            
        })
        
        task.resume()
    }
    
}

protocol APIControllerProtocol{
    func didReceiveAPIResults(results: NSDictionary)
}