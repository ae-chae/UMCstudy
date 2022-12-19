//
//  ViewController.swift
//  Standard5
//
//  Created by 윤채영 on 2022/11/05.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var counter: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var logTable: UITableView!
    

    
    var recordList: [String] = []
    
    
    //let alert = UIAlertController(title: "", message: "타이머 종료", preferredStyle: UIAlertController.Style.alert)
    //let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
    //        }

    // 시작과 기록의 상태
    enum WatchStatus {
        case start
        case stop
    }

    // 버튼의 상태
    var watchStatus: WatchStatus = .start
    
    var timer: Timer!
    var startTime =  Date()
    @IBAction func didTappedStartButton(_ sender: Any) {
        switch self.watchStatus {
        case .start:
            self.startTime = Date()
            self.watchStatus = .stop // 시작 상태가 되었기 때문에 상태를 바꾸어 줍니다.
            self.timer = Timer.scheduledTimer(timeInterval: 0.001,
                                              target: self,
                                              selector: #selector(timeUp),
                                              userInfo: nil,
                                              repeats: true)
        case .stop: // 기록 기능
            let hour = self.hourLabel.text ?? ""
            let minute = self.minuteLabel.text ?? ""
            let second = self.secondLabel.text ?? ""
            //let milliSecond = self.milliSecondLabel.text ?? ""
            
            let record = "\(hour) : \(minute) : \(second)"
            self.recordList.append(record)
            
            self.logTable.reloadData()
            UserDefaults.standard.set(self.recordList, forKey: "timeLog")
            
        }
    }
    
    @objc
        private func timeUp() {
            let timeInterval = Date().timeIntervalSince(self.startTime)

            let hour = (Int)(fmod((timeInterval/60/60), 12)) // 분을 12로 나누어 시를 구한다
            let minute = (Int)(fmod((timeInterval/60), 60)) // 초를 60으로 나누어 분을 구한다
            let second = (Int)(fmod(timeInterval, 60)) // 초를 구한다
            let milliSecond = (Int)((timeInterval - floor(timeInterval))*1000)

            self.hourLabel.text = String(format:"%02d", hour)
            self.minuteLabel.text = String(format:"%02d", minute)
            self.secondLabel.text = String(format:"%02d", second)
            //self.milliSecondLabel.text = String(format:"%03d", milliSecond)
        }
    
    @IBAction func didTappedResetButton(_ sender: Any) {
        if self.recordList.isEmpty { // 배열이 비어 있을 시 즉, 모든 기능을 취소한다.
                    self.watchStatus = .start // 상태도 원래의 상태로 돌립니다.

                    self.timer.invalidate() // 타이머 종료

                    self.hourLabel.text = "00"
                    self.minuteLabel.text = "00"
                    self.secondLabel.text = "00"
                    //self.milliSecondLabel.text = "000" // 모든 라벨을 다시 돌립니다.
                } else { // 타이머는 계속 진행, 테이블 뷰만 리셋한다.
                    self.recordList.removeAll()
                    self.logTable.reloadData()
                }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //alert.addAction(okAction)
        //counterEvent()
        recordList = UserDefaults.standard.array(forKey: "timeLog") as? [String] ?? []
        self.logTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.logTable.delegate = self
        self.logTable.dataSource = self
        
    }
    /*
    func counterEvent() {
        DispatchQueue.global().async {
            for i in (0...10).reversed(){
                DispatchQueue.main.async {
                    self.counter.text = String(i)
                }
                if(i == 0){
                    break
                }
                sleep(1)
            }
        }
        DispatchQueue.global().async {
            for i in (0...10).reversed(){
                if(i == 0){
                    DispatchQueue.main.async { [self] in
                        self.present(self.alert, animated: false, completion: nil)
                    }
                }
                sleep(1)
            }
        }
        
    }
     */
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.recordList[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.backgroundColor = .clear
        return cell
    }
}
