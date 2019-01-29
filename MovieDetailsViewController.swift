//
//  MovieDetailsViewController.swift
//  
//
//  Created by Work on 1/27/19.
//

import UIKit
import AlamofireImage  

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var backdrop: UIImageView!
    
    @IBOutlet weak var posterView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var synopsisLabel: UILabel!
    
    
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //print(movie["title"])
    
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        let base_URL = "https://image.tmdb.org/t/p/w185"
        let poster_path = movie["poster_path"] as! String
        let poster_URL = URL(string: base_URL + poster_path)
        
        posterView.af_setImage(withURL: poster_URL!)
        
        let backdropPath = movie["poster_path"] as! String
        let backdropURL = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
        
        backdrop.af_setImage(withURL: backdropURL!)
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
