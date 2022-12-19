//
//  ViewController.swift
//  Standard4
//
//  Created by 윤채영 on 2022/10/20.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    @IBOutlet weak var uiMemoList: UITableView!
    let refreshControl = UIRefreshControl()
    lazy var lottieView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "refreshLottie")
        animationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let centerX = UIScreen.main.bounds.width / 2
        animationView.center = CGPoint(x:centerX, y:40)
        animationView.contentMode = .scaleAspectFit
        animationView.stop()
        animationView.isHidden = true
        return animationView
    }()
    
    var memoList : [MemoData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        memoList.append(MemoData("쇼핑 목록", "2022.10.7.", "귤 한 박스"))
        memoList.append(MemoData("메모 1", "2022.10.8.", "내용 1"))
        memoList.append(MemoData("메모 2", "2022.10.9.", "내용 2"))
        memoList.append(MemoData("메모 3", "2022.10.10.", "내용 3"))
        memoList.append(MemoData("메모 4", "2022.10.11.", "내용 4"))
        memoList.append(MemoData("메모 5", "2022.10.12.", "내용 5"))
        memoList.append(MemoData("메모 6", "2022.10.13.", "내용 6"))
        memoList.append(MemoData("메모 7", "2022.10.14.", "내용 7"))
        memoList.append(MemoData("메모 8", "2022.10.15.", "내용 8"))
        memoList.append(MemoData("메모 9", "2022.10.15.", "내용 9"))
        memoList.append(MemoData("메모 10", "2022.10.15.", "내용 10"))
        memoList.append(MemoData("메모 11", "2022.10.15.", "내용 11"))
        memoList.append(MemoData("메모 12", "2022.10.15.", "내용 12"))
        memoList.append(MemoData("메모 13", "2022.10.15.", "내용 13"))
        memoList.append(MemoData("메모 14", "2022.10.15.", "내용 14"))
        memoList.append(MemoData("메모 15", "2022.10.15.", "내용 15"))
        memoList.append(MemoData("메모 16", "2022.10.15.", "내용 16"))
        memoList.append(MemoData("메모 17", "2022.10.15.", "내용 17"))
        memoList.append(MemoData("메모 18", "2022.10.15.", "내용 18"))
        
        
        uiMemoList.delegate = self
        uiMemoList.dataSource = self
        
        let memoCell = UINib(nibName: "MemoTableViewCell", bundle: nil)
        self.uiMemoList.register(memoCell, forCellReuseIdentifier: "MemoCell")

        initRefreshControl()
        
    }
    
    func initRefreshControl() {
        refreshControl.addSubview(lottieView)
        refreshControl.tintColor = .clear
        refreshControl.addTarget(self, action: #selector(refreshTableView(refreshControl:)), for: .valueChanged)
        uiMemoList.refreshControl = refreshControl
    }
    
    

}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell", for: indexPath) as? MemoTableViewCell else {
            return UITableViewCell()
        }
        let memoData : MemoData = memoList[indexPath.row]
        
        cell.uiTitle.text = memoData.title
        cell.uiDate.text = memoData.date
        cell.uiText.text = memoData.text
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            if editingStyle == .delete {
                
                memoList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            } else if editingStyle == .insert {
                
            }
        }
    
    @objc func refreshTableView(refreshControl: UIRefreshControl){
        lottieView.isHidden = false
        lottieView.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.lottieView.isHidden = true
            self.lottieView.stop()
            self.uiMemoList.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
}

