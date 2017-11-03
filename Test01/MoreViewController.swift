//
//  MoreViewController.swift
//  Test01
//
//  Created by IOS App on 17/1/27.
//  Copyright © 2017年 nova. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var topImageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "More"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreTableViewCell", for: indexPath) as! MoreTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.titleImage.image = #imageLiteral(resourceName: "first")
            cell.titleLable.text = "F"
        case 1:
            cell.titleImage.image = #imageLiteral(resourceName: "first")
            cell.titleLable.text = "u"
        case 2:
            cell.titleImage.image = #imageLiteral(resourceName: "first")
            cell.titleLable.text = "c"
        case 3:
            cell.titleImage.image = #imageLiteral(resourceName: "first")
            cell.titleLable.text = "k"
        case 4:
            cell.titleImage.image = #imageLiteral(resourceName: "first")
            cell.titleLable.text = "u"
        default:
            print()
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(SecondViewController(), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
