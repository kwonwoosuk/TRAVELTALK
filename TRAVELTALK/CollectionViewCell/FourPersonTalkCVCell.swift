//
//  OnePersonTalkCVCell.swift
//  TRAVELTALK
//
//  Created by 권우석 on 1/11/25.
//

import UIKit

class FourPersonTalkCVCell: UICollectionViewCell {
    static let identifier = "FourPersonTalkCVCell"
    
    @IBOutlet weak var firstUserImageView: UIImageView!
    @IBOutlet weak var secondUserImageView: UIImageView!
    @IBOutlet weak var thirdUserImageView: UIImageView!
    @IBOutlet weak var fourthUserImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userMessageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            
            let imageViews = [firstUserImageView, secondUserImageView,
                             thirdUserImageView, fourthUserImageView]
            imageViews.forEach { imageView in
                imageView?.layer.cornerRadius = (imageView?.frame.height ?? 0) / 2
            }
        }
    
    private func setupCell() {
        
        let imageViews = [firstUserImageView, secondUserImageView, thirdUserImageView, fourthUserImageView]
        
        imageViews.forEach { imageView in
            imageView?.contentMode = .scaleAspectFill
            imageView?.clipsToBounds = true
            imageView?.backgroundColor = .systemGray6
        }
        
        
        userNameLabel.font = .boldSystemFont(ofSize: 16)
        userNameLabel.textColor = .black
        userNameLabel.numberOfLines = 1
        
        // Configure message label
        userMessageLabel.font = .systemFont(ofSize: 14)
        userMessageLabel.textColor = .darkGray
        userMessageLabel.numberOfLines = 2
        
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .gray
        dateLabel.textAlignment = .right
    }
    
    func configure(with chatRoom: ChatRoom) {
        
        if chatRoom.chatroomImage.count >= 4 {
            firstUserImageView.image = UIImage(named: chatRoom.chatroomImage[0])
            secondUserImageView.image = UIImage(named: chatRoom.chatroomImage[1])
            thirdUserImageView.image = UIImage(named: chatRoom.chatroomImage[2])
            fourthUserImageView.image = UIImage(named: chatRoom.chatroomImage[3])
        }
        userNameLabel.text = chatRoom.chatroomName
        
        
        if let lastChat = chatRoom.chatList.last {
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
        
        dateFormatter.dateFormat = "yy/MM/dd"
        return dateFormatter.string(from: date)
    }
}
    
