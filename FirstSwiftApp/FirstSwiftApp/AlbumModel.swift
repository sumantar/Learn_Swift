//
//  AlbumModel.swift
//  FirstSwiftApp
//
//  Created by sumantar on 25/08/14.
//  Copyright (c) 2014 sumantar. All rights reserved.
//

import Foundation

class AlbumModel{
    let title: String
    let price: String
    let thumbnailImageURL: String
    let largeImageURL: String
    let itemURL: String
    let artistURL: String
    let collectionId: Int
    //With the collectionId, it’s easy to do a second query of the iTunes API to gather lots of details about an individual album
    
    init(name: String, price: String, thumbnailImageURL: String, largeImageURL: String, itemURL: String, artistURL: String, collectionId: Int) {
        self.title = name
        self.price = price
        self.thumbnailImageURL = thumbnailImageURL
        self.largeImageURL = largeImageURL
        self.itemURL = itemURL
        self.artistURL = artistURL
        self.collectionId = collectionId
    }
    
    class func objectsFromJSONArray(jsonResponse: NSArray) -> [AlbumModel]{
        var albums = [AlbumModel]()
        
        if(jsonResponse.count > 0){
            for album in jsonResponse{
                
                //Set the title
                var name = album["trackName"] as? String
                
                if name == nil {
                    name = album["collectionName"] as? String
                }
                
                //Set the price
                var price = album["formattedPrice"] as? String
                if price == nil {
                    price = album["collectionPrice"] as? String
                    if price == nil {
                        var priceFloat: Float? = album["collectionPrice"] as? Float
                        var nf: NSNumberFormatter = NSNumberFormatter()
                        nf.maximumFractionDigits = 2;
                        
                        if priceFloat != nil {
                            price = "$"+nf.stringFromNumber(priceFloat)
                        }
                    }
                }
                //Note about double optional operator
                //let finalVariable = possiblyNilVariable ?? "Definitely Not Nil Variable"
                
                //Set Thumbnail URL
                let thumbnailURL = album["artworkUrl60"] as? String ?? ""
                
                //Set Large image URL
                let imageURL = album["artworkUrl100"] as? String ?? ""
                
               
                //Set item url
                var itemURL = album["collectionViewUrl"] as? String
                if itemURL == nil {
                    itemURL = album["trackViewUrl"] as? String
                }
                
                //Set artist URL
                let artistURL = album["artistViewUrl"] as? String ?? ""
                
                //CollectionID. With the collectionId, it’s easy to do a second query of the iTunes API to gather lots of details about an individual album
                let collectionID = album["collectionId"] as? Int
                
                //Create Model Object
                var albumModel = AlbumModel(name: name!, price: price!, thumbnailImageURL: thumbnailURL, largeImageURL: imageURL, itemURL: itemURL!, artistURL: artistURL, collectionId: collectionID!)
                
                //Add Models into Array
                albums.append(albumModel)
            }
        }
        
        return albums
    }
}