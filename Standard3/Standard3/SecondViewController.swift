//
//  SecondViewController.swift
//  Standard3
//
//  Created by 윤채영 on 2022/10/06.
//

import Foundation
import UIKit


class SecondViewController: UIViewController {

    @IBOutlet weak var uiResult: UILabel!
    
    var result : String? = "Default"
    
    
    @IBAction func didTapAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        uiResult.text = result
    }

    override func viewWillAppear(_ animated: Bool) {
        print("second: viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("second: viewDidAppear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("second: viewDidDisappear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        print("second: viewWillDisappear")
    }
}

