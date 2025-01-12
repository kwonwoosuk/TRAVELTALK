//
//  OnePersonTalkCVCell.swift
//  TRAVELTALK
//
//  Created by 권우석 on 1/11/25.
//

import UIKit

class OnePersonTalkCVCell: UICollectionViewCell {
    static let identifier = "OnePersonTalkCVCell"
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userMessageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    private func setupCell() {
        userImageView.contentMode = .scaleAspectFit
        userImageView.clipsToBounds = true
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
        userImageView.backgroundColor = .systemGray6
        
        userNameLabel.font = .boldSystemFont(ofSize: 16)
        userNameLabel.textColor = .black
        userNameLabel.numberOfLines = 1
        
        userMessageLabel.font = .systemFont(ofSize: 14)
        userMessageLabel.textColor = .darkGray
        userMessageLabel.numberOfLines = 2
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .gray
        dateLabel.textAlignment = .right
    }
    
    func configure(with chatRoom: ChatRoom) {
        
        userImageView.image = UIImage(named: chatRoom.chatroomImage[0])
        userNameLabel.text = chatRoom.chatroomName
        
        if let lastChat = chatRoom.chatList.last{ // 마지막 대화 날짜만 보여주기
            userMessageLabel.text = lastChat.message
            dateLabel.text = formatDate(lastChat.date)
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
