//
//  ViewController.swift
//  MacDigger
//
//  Created by Stas Panasuk on 3/22/18.
//  Copyright © 2018 iSan4eZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tvNews: UITableView!
    
    var newsList = [News]()
    
    struct News {
        var image : UIImage = #imageLiteral(resourceName: "empty_image")
        let topic : String!
        let date : String!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvNews.delegate = self
        tvNews.dataSource = self
        tvNews.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        tvNews.rowHeight = UITableViewAutomaticDimension
        tvNews.estimatedRowHeight = 300
        
        newsList = [News.init(image: #imageLiteral(resourceName: "empty_image"), topic: "Как Apple создаёт рекламые видео", date: "22 МАР, 2018"),
        News.init(image: #imageLiteral(resourceName: "empty_image"), topic: "Разработчики игры The Walking Dead: Our World используют iPhone X для создания персонажей", date: "22 МАР, 2018"),
        News.init(image: #imageLiteral(resourceName: "empty_image"), topic: "Apple запустит тестовое производство iPhone 2018 года в апреле", date: "22 МАР, 2018"),
        News.init(image: #imageLiteral(resourceName: "empty_image"), topic: "Почему блокировка Telegram вызвала большой ажиотаж", date: "22 МАР, 2018"),
        News.init(image: #imageLiteral(resourceName: "empty_image"), topic: "Apple Watch определяют аритмию с точностью 97%", date: "22 МАР, 2018")]
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
        cell.mainImage = newsList[indexPath.row].image
        cell.topic = newsList[indexPath.row].topic
        cell.date = newsList[indexPath.row].date
        cell.layoutSubviews()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

