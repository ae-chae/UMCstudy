//
//  ViewController.swift
//  Standard9
//
//  Created by 윤채영 on 2022/11/24.
//

import UIKit
import KakaoSDKUser
import KakaoSDKAuth

class ViewController: UIViewController {

    
    @IBAction func kakaoLoginButtonTouchUpInside(_ sender: Any) {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            
            //카톡 설치되어있으면 -> 카톡으로 로그인
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 톡으로 로그인 성공")
                    
                    _ = oauthToken
                    /// 로그인 관련 메소드 추가
                }
            }
        } else {

            // 카톡 없으면 -> 계정으로 로그인
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 계정으로 로그인 성공")
                    
                    _ = oauthToken
                    // 관련 메소드 추가
                }
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
    }


}

