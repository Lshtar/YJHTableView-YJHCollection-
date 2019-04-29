//
//  ColumnViewController.swift
//  YJHTableView(YJHCollection)
//
//  Created by D on 2018/10/8.
//  Copyright © 2018年 D. All rights reserved.
//

import UIKit

class ColumnViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var tabV : UITableView!
    var array : NSArray!
    var expendArr : NSArray!
    var isExpend = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view!.backgroundColor = UIColor.white
        self.title = "Swift TableViewCell展开关闭"
        array = ["1","2","3","4"];
        expendArr = ["1","2","3","4","5","6","7"];
        
        tabV = UITableView.init(frame: self.view.bounds, style: UITableView.Style.plain)
        tabV.backgroundColor = UIColor.clear
        tabV.dataSource = self
        tabV.delegate = self
        tabV.frame = self.view.bounds
        self.view.addSubview(tabV!)
        
        tabV.register(ColumnCell.self, forCellReuseIdentifier: "columnCellIdentifier")
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isExpend {
            return expendArr.count
        }else{
            return array.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let columnCellIdenfifier = "columnCellIdentifier"
        var  columnCell: ColumnCell = tableView.dequeueReusableCell(withIdentifier: columnCellIdenfifier) as! ColumnCell
        
        //let columnCell = tableView.dequeueReusableCell(withIdentifier: columnCellIdenfifier, for:indexPath )
        if columnCell.isEqual(nil) {
            columnCell = ColumnCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: columnCellIdenfifier)
        }
        if isExpend {
            columnCell.titleLabel?.text = String(format: "%@",expendArr![indexPath.row] as! CVarArg)
            //columnCell.iconImageV?.image = expendArr![indexPath.row] as! UIImage
        }else
        {
            columnCell.titleLabel?.text = String(format: "%@", array![indexPath.row] as! CVarArg)
        }
        return columnCell
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let btn = UIButton()
        btn.backgroundColor = UIColor.cyan
        if isExpend {
            btn.setTitle("关闭", for: UIControl.State.normal)
        }else
        {
            btn.setTitle("展开", for: UIControl.State.normal)
        }
        btn.addTarget(self, action: #selector(click), for: UIControl.Event.touchUpInside)
        return btn
    }
    @objc func click(btn:UIButton){
        isExpend = !isExpend
        tabV.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
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
