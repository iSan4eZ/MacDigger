//
//  ViewController.swift
//  MacDigger
//
//  Created by Stas Panasuk on 3/22/18.
//  Copyright © 2018 iSan4eZ. All rights reserved.
//

import UIKit
import Alamofire

struct News {
    var image : URL!
    let topic : String!
    let date : String!
    let index : Int!
    let url : URL!
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tvNews: UITableView!
    
    var newsList = [News]()
    
    let userAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1"
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvNews.delegate = self
        tvNews.dataSource = self
        tvNews.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        tvNews.rowHeight = UITableViewAutomaticDimension
        tvNews.estimatedRowHeight = 300
        
        for i in 1...10{
            loadNews(page: i, completion: {})
        }
    }

    func loadNews(page: Int, completion: @escaping () -> ()) {
        Alamofire.request("http://macdigger.ru/page/\(page)", headers: ["User-Agent": userAgent]).response { response in
            if let data = response.data, let htmlCode = String(data: data, encoding: .utf8) {
                let rawNews = htmlCode.sliceToArray(from: "<div class=\"post section post-", to: "</a>")!
                for topic in rawNews{
                    let index = Int(topic.split(separator: " ").first!.description)
                    if !self.newsList.contains { $0.index == index }{
                        self.newsList.append(News.init(
                            image: URL.init(string: topic.sliceToArray(from: "src=\"", to: "\" alt=\"")!.first!),
                            topic: topic.sliceToArray(from: "<h2 class=\"post-title heading-font\">", to: "</h2>")!.first,
                            date: topic.sliceToArray(from: "<span class=\"post-date-author body-font\">\n\t\t\t", to: "\t\t \t\t\t </span>")!.first,
                            index: index,
                            url: URL.init(string: topic.sliceToArray(from: "<a href=\"", to: "\" class=\"loop-link tappable clearfix \">")!.first!)
                        ))
                    }
                    self.tvNews.beginUpdates()
                    self.tvNews.insertRows(at: [IndexPath(row: self.newsList.count-1, section: 0)], with: .fade)
                    self.tvNews.endUpdates()
                }
            }
            completion()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tvNews.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        cell.news = newsList[indexPath.row]
        cell.layoutSubviews()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension String {
    
    func sliceToArray(from: String, to: String) -> [String]? {
        var result = [String]()
        if self.contains(from){
            var startRange = self.range(of: from)!
            let endRange = range(of: to, range: (startRange.upperBound..<self.endIndex))!
            while let a = range(of: from, range: (startRange.upperBound..<endRange.lowerBound)) {
                startRange = a
            }
            result.append(String(self[startRange.upperBound..<endRange.lowerBound]))
            let next = self[startRange.upperBound..<self.endIndex]
            let out = String(next).sliceToArray(from: from, to: to)
            if out != nil && out!.count > 0{
                for i in out!{
                    result.append(i)
                }
            }
        }
        return result
    }
    
    func slice(from: String, to: String) -> String? {
        if self.contains(from){
            let startRange = self.range(of: from)!
            let endRange = range(of: to, range: (startRange.upperBound..<self.endIndex))!
            return(String(self[startRange.upperBound..<endRange.lowerBound]))
        }
        return nil
    }
}
