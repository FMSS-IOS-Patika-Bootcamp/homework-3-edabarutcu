//
//  PostViewController.swift
//  Homework3
//
//  Created by detaysoft on 19.09.2022.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var postTableView: UITableView!
    var posts = [Post]()
    let activityIndicatorView = UIActivityIndicatorView(style: .large)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        activityIndicatorView.center = view.center
        activityIndicatorView.startAnimating()
        view.addSubview(activityIndicatorView)
        postTableView.isHidden = true
        activityIndicatorView.isHidden = false
        
        postTableView.delegate = self
        postTableView.dataSource = self
        
        showPosts()
    }
    
    func showPosts() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let decodedPosts = try? JSONDecoder().decode([Post].self, from: data) {
                    self.posts = decodedPosts
                    DispatchQueue.main.async {
                        self.activityIndicatorView.stopAnimating()
                        self.activityIndicatorView.isHidden = true
                        self.postTableView.reloadData()
                        self.postTableView.isHidden = false
                    }
                } else {
                   debugPrint("Failure to decode posts.")
               }
            } else {
                debugPrint("Failure to get data.")
            }
        }.resume()
        
    }

}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostTableViewCell else { return PostTableViewCell() }
        cell.setUpView(post: posts[indexPath.row])
        return cell
    }
    
}





