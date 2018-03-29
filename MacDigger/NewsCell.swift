//
//  NewsCell.swift
//  MacDigger
//
//  Created by Stas Panasuk on 3/22/18.
//  Copyright © 2018 iSan4eZ. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class NewsCell : UITableViewCell {
    
    var news : News!
    
    var imagePreview : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var topicView : UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.font = UILabel().font.withSize(15)
        return textView
    }()
    
    var dateView : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.gray
        label.font = label.font.withSize(8)
        return label
    }()
    
    var rightArrow : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.white
        label.text = ">"
        label.textColor = UIColor.gray
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(imagePreview)
        self.addSubview(topicView)
        self.addSubview(dateView)
        self.addSubview(rightArrow)
        
        rightArrow.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        rightArrow.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        rightArrow.textAlignment = .right
        
        imagePreview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        imagePreview.widthAnchor.constraint(equalToConstant: 75).isActive = true
        imagePreview.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imagePreview.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imagePreview.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -10).isActive = true
        
        topicView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        topicView.leftAnchor.constraint(equalTo: imagePreview.rightAnchor, constant: 5).isActive = true
        topicView.rightAnchor.constraint(lessThanOrEqualTo: rightArrow.leftAnchor, constant: -5).isActive = true
        
        dateView.topAnchor.constraint(equalTo: topicView.bottomAnchor).isActive = true
        dateView.leftAnchor.constraint(equalTo: topicView.leftAnchor, constant: 5).isActive = true
        dateView.rightAnchor.constraint(equalTo: rightArrow.leftAnchor, constant: -5).isActive = true
        dateView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -10).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let mainImage = news.image{
            
            imagePreview.sd_setImage(with: mainImage)
        }
        if let topic = news.topic{
            topicView.text = "\(news.index) - \(topic)"
        }
        if let date = news.date{
            dateView.text = date
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
