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
        setTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = roomName
    }
    
    func setTableView() {
        chatRmTableView.delegate = self
        chatRmTableView.dataSource = self
        
        chatRmTableView.separatorStyle = .none
        let userXib = UINib(nibName:  FriendVCCell.identifier, bundle: nil) //  bundle이거도 궁금함‼️ 그만 알아보도록 하자
        let friendXib = UINib(nibName: UserVCCell.identifier, bundle: nil)
        chatRmTableView.register(userXib, forCellReuseIdentifier: FriendVCCell.identifier)
        chatRmTableView.register(friendXib, forCellReuseIdentifier: UserVCCell.identifier)
        
    }
    
}
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    //섹션의 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chatContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellOfRow = chatContent[indexPath.row]
        
        if cellOfRow.user != User.user {  // 내가 보낸게 아니면 이미지뷰가 없는 firendvccell사용
            guard let userCell = tableView.dequeueReusableCell(withIdentifier: FriendVCCell.identifier) as? FriendVCCell else {
                return UITableViewCell()
            }
            userCell.configureChat(row: cellOfRow)
            return userCell
        } else {
            guard let friendCell = tableView.dequeueReusableCell(withIdentifier: UserVCCell.identifier) as? UserVCCell else {
                return UITableViewCell() // 분기처리할거면 없는경우도 대비 해줘야 오류가 안나는군요...
            }
            friendCell.configureChat(row: cellOfRow)
            return friendCell
        }
        
    }
}




