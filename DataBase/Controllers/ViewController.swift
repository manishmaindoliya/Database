//
//  ViewController.swift
//  DataBase
//
//  Created by HeMu on 05/07/17.
//  Copyright © 2017 HeMu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView_Info: UITableView!

    var arrName : NSMutableArray?

    override func viewDidLoad() {
       super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DBManager.shared.getPersonInfo { (_ result) in
            self.arrName = result
            self.tableView_Info.reloadData()
        }
        
        
        //print("commited Value")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

    extension ViewController : UITableViewDelegate,UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrName!.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell:cell_Info = tableView_Info.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell as! cell_Info
        
        let person           = arrName?.object(at: indexPath.row) as? PersonModel
        cell.LabelName.text  = person?.person_Fname!
        cell.labelCity.text  = person?.person_city!
        cell.btnDel.tag      = indexPath.row
        cell.btnDel.addTarget(self, action: #selector(self.deleteFunc), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person           = arrName?.object(at: indexPath.row) as? PersonModel
        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "editProfileVC") as! editProfileVC
        destinationVC.personInfo = person
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func deleteFunc(_ sender : UIButton)  {
        let person           = arrName?.object(at: sender.tag) as? PersonModel
        let p_id = person?.person_id!
        DBManager.shared.removeInfoPerson(p_info: ["p_id":"\(p_id!)"]) {
                print("delete successFully")
            
       // DBManager.removeInfoPerson()
            
            self.arrName?.removeObject(at: sender.tag)
            self.tableView_Info.reloadData()
        }
    }
}
