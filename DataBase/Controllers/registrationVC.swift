//
//  registrationVC.swift
//  DataBase
//
//  Created by HeMu on 05/07/17.
//  Copyright © 2017 HeMu. All rights reserved.
//

import UIKit

class registrationVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var txtfldCity: UITextField!
    @IBOutlet weak var txtfldAddress: UITextField!
    @IBOutlet weak var txtfldLname: UITextField!
    @IBOutlet weak var txtfldfirstName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnHandlerNex(_ sender: Any) {
        DBManager.shared.insertIntoPerson(p_info: ["p_fname":"\(self.txtfldfirstName.text!)","p_lname":"\(self.txtfldLname.text!)","p_add":"\(self.txtfldAddress.text!)","p_city":"\(self.txtfldCity.text!)"]) {
        
            let distinationVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.navigationController?.pushViewController(distinationVC, animated: true)
        }
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnClickOnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
