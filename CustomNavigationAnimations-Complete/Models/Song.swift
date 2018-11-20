//
//  Song.swift
//  CustomNavigationAnimations-Starter
//
//  Created by Sam Stone on 29/09/2017.
//  Copyright © 2017 Sam Stone. All rights reserved.
//

import UIKit

struct Song {
    var artist : String
    var title : String
    var artwork : UIImage
    
    static var mockup = [Song(artist: "Kendrick Lamar", title: "DNA", artwork: UIImage(named: "damn")!),
                         Song(artist: "Freddie Gibbs", title: "Alexys", artwork: UIImage(named: "twice")!),
                         Song(artist: "Brockhampton", title: "JUNKY", artwork: UIImage(named: "sat")!),
                         Song(artist: "MC Eiht", title: "Represent Like This", artwork: UIImage(named: "west")!),
                         Song(artist: "Tyler the Creator", title: "November", artwork: UIImage(named: "flower")!),
                         Song(artist: "Jay-Z", title: "4:44", artwork: UIImage(named: "four")!),
                         Song(artist: "Joey Bada$$", title: "ROCKABYE BABY", artwork: UIImage(named: "badass")!),
                         Song(artist: "Sean Price", title: "Imperious Rex", artwork: UIImage(named: "imperious")!),
                         Song(artist: "Oddisee", title: "Hold it back", artwork: UIImage(named: "iceburg")!),
                         Song(artist: "J.I.D", title: "Never", artwork: UIImage(named: "never")!)]
}
