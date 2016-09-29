//
//  ViewController.swift
//  BookList
//
//  Created by Andrew Barber on 9/27/16.
//  Copyright © 2016 Invictus. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    class Book {
        
        let title : String?
        let author : String?
        let imageURL : String?
        
        init (title: String?, author: String?, imageURL : String?) {
            
            self.title = title
            self.author = author
            self.imageURL = imageURL
            
        }
        
    }
    
    
    @IBOutlet var bookList: UITableView!
    
    var books = [Book]()
    var ebayUrlString : String = "http://calm-mountain-87063.herokuapp.com/books.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookList.delegate = self
        bookList.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
        // Fetch Data Here
        // Step 1) Convert UrlString to Url
        let url = URL(string: ebayUrlString)
        
        if let url = url { // this unwraps url
            
            // Step 2) Make Networking variables
            let session = URLSession.shared
            
            // Step 3) Make Networking task
            let task = session.dataTask(with: url, completionHandler: { (data, resonse, error) in
                // The task was complete, now we can do stuff
                
                // Step 5) Convert data to JSON
                guard let data = data else { return }
                
                var json: Any?
                do {
                    json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                } catch let error {
                    print("error = \(error)")
                }
                
                // Step 6) Convert JSON into Objects
                
                if let json = json as? [[String: AnyObject]] {
                    
                    for dictionary in json {
                        
                        let title = dictionary["title"] as? String
                        let author = dictionary["author"] as? String
                        let imageURL = dictionary["image_url"] as? String
                        
                        let book = Book(title: title, author: author, imageURL: imageURL)
                        
                        self.books.append(book)
                        
                        print("\(book.title) \(book.author) \(book.imageURL)")
                        
                    }
                }
                
                //Step 7) Parsing is complete - reload table view
                
                DispatchQueue.main.async {
                    self.bookList.reloadData()
                }
                
                
                
            })
            
            // Step 4)
            task.resume()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ : UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomCell
        
        let book = books[indexPath.row]
        
        cell.title.text = book.title
        cell.author.text = book.author
        cell.imageURL.text = book.imageURL
        
        return cell
        
    }
    
}





























