//
//  TuningViewController.swift
//  TERUMIN
//
//  Created by Oshima Haruna on 2018/06/16.
//  Copyright © 2018年 IkukoHiraga. All rights reserved.
//

import UIKit

class TuningViewController: UIViewController {

    @IBOutlet weak var peopleLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func startButtonTapped(_ sender: Any) {
        ConnectionManager.sendMessageEvent(message: "start")
        sceneChange1()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        joinPeople()

        ConnectionManager.onConnect{ _, _ in
            print("特定の端末が接続された")
            self.updatePeers()
            
            self.joinPeople()
        }
        
        ConnectionManager.onDisconnect { _, _ in
            print("特定の端末が切断された")
            self.updatePeers()
            
            self.joinPeople()
        }
        
        ConnectionManager.onEvent(.Message) { [unowned self] _, object in
            self.receiveMassage(object: object)
         }
        
        ConnectionManager.sendMessageEvent(message: "join")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ConnectionManager.start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ConnectionManager.onConnect(nil)
        ConnectionManager.onDisconnect(nil)
        
        super.viewWillDisappear(animated)
    }
 
    private func receiveMassage(object: AnyObject?) {
        print("@@recieve")
        guard let data = object else {
            return
        }
        if let message = data["message"] as? String, let from = data["from"] as? String{
            if message == "start"{
                startSession(message:message, from)
            }
        }
    }
    
    private func startSession(message: String, _ from: String) {
        sceneChange1()
    }
    
    private func sceneChange1(){
        let storyboard: UIStoryboard = self.storyboard!
        let sessionView = storyboard.instantiateViewController(withIdentifier: "session") as! SessionViewController
        self.present(sessionView, animated: true, completion: nil)
    }
    
    private func joinPeople(){
        let length = ConnectionManager.peers.count + 1
        self.peopleLabel.text = "\(length) 人参加中"
    }
    
    private func updatePeers() {
        // TODO: コネクション一覧が更新された場合の処理を実装する
        print(ConnectionManager.peers)
    }
    
}
