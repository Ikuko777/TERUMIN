//
//  SessionViewController.swift
//  TERUMIN
//
//  Created by Oshima Haruna on 2018/06/16.
//  Copyright © 2018年 IkukoHiraga. All rights reserved.
//

import UIKit

class SessionViewController: UIViewController {

    @IBOutlet weak var stopButton: UIButton!
    
    @IBAction func stopButtonTapped(_ sender: Any) {
        ConnectionManager.sendMessageEvent(message: "stop")
        sceneChange2()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectionManager.onEvent(.Message) { [unowned self] _, object in
            self.receiveMassage(object: object)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func receiveMassage(object: AnyObject?) {
        print("@@@recieve")
        guard let data = object else {
            return
        }
        if let message = data["message"] as? String, let from = data["from"] as? String{
            if message == "stop" {
                stopSession(message:message, from)
            }
        }
    }
    
    private func stopSession(message: String, _ from: String) {
        sceneChange2()
    }
    
    
    private func sceneChange2(){
        let storyboard: UIStoryboard = self.storyboard!
        let endingView = storyboard.instantiateViewController(withIdentifier: "ending") as! EndingViewController
        self.present(endingView, animated: true, completion: nil)
    }

}
