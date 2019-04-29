//
//  ColumnCell.swift
//  YJHTableView(YJHCollection)
//
//  Created by D on 2018/10/10.
//  Copyright © 2018年 D. All rights reserved.
//

import UIKit

class ColumnCell: UITableViewCell {

    var titleString : String?
    var iconImageName : String?
    
    var titleLabel : UILabel?
    var iconImageV : UIImageView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier:reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none

        self.creatCellUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func creatCellUI (){
        iconImageV = UIImageView.init(frame: CGRect(x:15.0,y:5.0,width:50,height:40))
        iconImageV!.backgroundColor = UIColor.lightGray
        self.contentView.addSubview(iconImageV!)
        
        titleLabel = UILabel.init(frame: CGRect(x:70,y:0,width:100,height:20))
        titleLabel!.backgroundColor = UIColor.clear
        self.contentView.addSubview(titleLabel!)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
