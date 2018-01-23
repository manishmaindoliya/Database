//
//  editProfileVC.swift
//  DataBase
//
//  Created by HeMu on 05/07/17.
//  Copyright © 2017 HeMu. All rights reserved.
//

import UIKit

class editProfileVC: UIViewController {

    
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtLName: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtAdd: UITextField!
    
    var personInfo : PersonModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtFName.text = personInfo?.person_Fname
        txtLName.text = personInfo?.person_Lname
        txtAdd.text   = personInfo?.person_address
        txtCity.text  = personInfo?.person_city
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnClicksOnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnClicksOnSubmit(_ sender: UIButton) {
     
        let p_id = personInfo?.person_id!
        
        DBManager.shared.UpdateInfoPerson(p_info: ["p_id":"\(p_id!)","p_fname":"\(self.txtFName.text!)","p_lname":"\(self.txtLName.text!)","p_add":"\(self.txtAdd.text!)","p_city":"\(self.txtCity.text!)"]) {
            
            let distinationVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.navigationController?.pushViewController(distinationVC, animated: true)
        }
    }
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

