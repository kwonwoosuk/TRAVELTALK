//
//  ChatViewController.swift
//  TRAVELTALK
//
//  Created by 권우석 on 1/11/25.
//

import UIKit

class ChatViewController: UIViewController {
    //Pass Data 1
    var roomName: String? //chatroomName 채팅방 이름 불러오기
    var chatContent: [Chat] = [] // user, data. message등 불러올 배열
    
    @IBOutlet weak var chatRmTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(chatContent)
        
    }
    
    
    
    
    func setTableView() {
        
        
        
        
        
    }
    
    
    
    }
    extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            <#code#>
        }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            <#code#>
        }
    
    
    
}
