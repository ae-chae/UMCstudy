//
//  ViewController.swift
//  Standard3
//
//  Created by 윤채영 on 2022/10/06.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var uiTextField: UITextField!
    
    @IBAction func didTapAction(_ sender: Any) {
        
        let data : String = uiTextField.text!
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        
        secondViewController.result = data
        
        self.present(secondViewController, animated: true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
    }
}

