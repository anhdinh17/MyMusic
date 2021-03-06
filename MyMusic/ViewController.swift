//
//  ViewController.swift
//  MyMusic
//
//  Created by Anh Dinh on 3/1/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var table: UITableView!
    
    var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSongs()
        
        table.delegate = self
        table.dataSource = self
    }
    
    //MARK: - func configureSongs()
    func configureSongs(){
        songs.append(Song(name: "First Song",
                          albumName: "First Album",
                          artistName: "Frist Artist",
                          imageName: "cover1",
                          trackName: "song1"))
        
        songs.append(Song(name: "Second Song",
                          albumName: "2nd Album",
                          artistName: "2nd Artist",
                          imageName: "cover2",
                          trackName: "song2"))
        
        songs.append(Song(name: "3rd Song",
                          albumName: "3rd Album",
                          artistName: "3rd Artist",
                          imageName: "cover3",
                          trackName: "song3"))
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator // arrow on the cell
        cell.textLabel?.text = song.name
        cell.imageView?.image = UIImage(named: song.imageName)
        cell.detailTextLabel?.text = song.albumName // subtitle on Prototype Cell
        
        // adjust font
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 17)
        
        return cell
    }
    
    // height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // present the player
        let position = indexPath.row
        
        // set vc to be PlayerViewController
        guard let vc = storyboard?.instantiateViewController(identifier: "player") as? PlayerViewController else {
            return
        }
        
        // set values of variables of PlayerViewController
        // this is like prepare segueWay
        vc.songs = songs
        vc.position = position
        
        // clicking on cell goes to PlayerViewController
        // This way is like segueWay
        present(vc,animated: true)
    }

}


struct Song {
    let name: String
    let albumName: String
    let artistName: String
    let imageName: String
    let trackName: String
}
