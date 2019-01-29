//
//  MoviesViewController.swift
//  flixster
//
//  Created by Work on 1/20/19.
//  Copyright © 2019 galvez2j. All rights reserved.
//

// Credits
// Icon made by mynamepong from www.flaticon.com

import UIKit
import AlamofireImage

// Remember to add subclasses for the tableView

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // This chunk of code download an array of movies
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                
                // TODO: Get the array of movies
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                
                // TODO: Store the movies in a property to use elsewhere
                 self.movies = dataDictionary["results"] as! [[String:Any]]
                
                // TODO: Reload your table view data
                self.tableView.reloadData()
            }
        }
        task.resume()
        

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create a cell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movie = movies[indexPath.row]
        
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        
        let base_URL = "https://image.tmdb.org/t/p/w185"
        let poster_path = movie["poster_path"] as! String
        let poster_URL = URL(string: base_URL + poster_path)
        
        cell.titleLabel.text = title
        cell.synopsisLabel.text = synopsis
        cell.posterView.af_setImage(withURL: poster_URL!)
        
        return cell
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        print("Loading up the details screen...")
        
        //find the selected movie
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        
        let movie = movies[indexPath.row]
        
        // pass the selected movie to the details view controller
        
        let detailsViewController = segue.destination as! MovieDetailsViewController
        
        detailsViewController.movie = movie
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    

}
