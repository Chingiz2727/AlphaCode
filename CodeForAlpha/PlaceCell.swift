//
//  ChoosePlaceTableViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 15.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit


class ChoosePlaceTableViewCell: UITableViewCell {
    
    let img = UIImageView()
    let label = MainLabel()
    let view = UIView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setView() {
        self.addSubview(view)
        view.addSubview(label)
        label.initialize()
        view.addSubview(img)
        img.contentMode = .scaleAspectFill
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.text = "che tam"
        let centerY = img.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let centerYLabel = label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        label.setAnchor(top: self.topAnchor, left: img.rightAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10)
        label.numberOfLines = 0
        img.setAnchor(top: nil, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 30, paddingBottom: 0, paddingRight: 0,width: 20,height: 20)
        NSLayoutConstraint.activate([centerY,centerYLabel])
        self.backgroundColor = nil
        self.selectionStyle = .none
    }
}


