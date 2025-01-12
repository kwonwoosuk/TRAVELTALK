//
//  OnePersonTalkCVCell.swift
//  TRAVELTALK
//
//  Created by 권우석 on 1/11/25.
//

import UIKit

class ThreePersonTalkCVCell: UICollectionViewCell {
    
    static let identifier = "ThreePersonTalkCVCell"
    
    @IBOutlet weak var firstUserImageView: UIImageView!
    @IBOutlet weak var secondUserImageView: UIImageView!
    @IBOutlet weak var thirdUserImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userMessageLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCell()
    }
    
    func setCell() {
        firstUserImageView.contentMode = .scaleAspectFill
        firstUserImageView.clipsToBounds = true
        firstUserImageView.layer.cornerRadius = firstUserImageView.frame.height / 2
        firstUserImageView.backgroundColor = .systemGray6
        
        secondUserImageView.contentMode = .scaleAspectFill
        secondUserImageView.clipsToBounds = true
        secondUserImageView.layer.cornerRadius = secondUserImageView.frame.height / 2
        secondUserImageView.backgroundColor = .systemGray6
        
        thirdUserImageView.contentMode = .scaleAspectFill
        thirdUserImageView.clipsToBounds = true
        thirdUserImageView.layer.cornerRadius = thirdUserImageView.frame.height / 2
        thirdUserImageView.backgroundColor = .systemGray6
        
        // 이름 레이블 설정
        userNameLabel.font = .boldSystemFont(ofSize: 16)
        userNameLabel.textColor = .black
        userNameLabel.numberOfLines = 1
        
        // 메시지 레이블 설정
        userMessageLabel.font = .systemFont(ofSize: 14)
        userMessageLabel.textColor = .darkGray
        userMessageLabel.numberOfLines = 2
        
        // 날짜 레이블 설정
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .gray
        dateLabel.textAlignment = .right
    }
    
    // 채팅방 데이터로 셀 구성하는 메서드
    func configure(with chatRoom: ChatRoom) {
        // 프로필 이미지 설정 - User enum에 따라 분기 처리
        firstUserImageView.image = UIImage(named: chatRoom.chatroomImage[0])
        secondUserImageView.image = UIImage(named: chatRoom.chatroomImage[1])
        thirdUserImageView.image = UIImage(named: chatRoom.chatroomImage[2])
        userNameLabel.text = chatRoom.chatroomName
        
        // 최근 메시지와 날짜 설정
        if let lastChat = chatRoom.chatList.last {
            userMessageLabel.text = lastChat.message
            if let date = formatDate(lastChat.date) {
                dateLabel.text = date
            }
        }
    }
    
    private func formatDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        
        dateFormatter.dateFormat = "yy.MM.dd"
        return dateFormatter.string(from: date)
    }
}

