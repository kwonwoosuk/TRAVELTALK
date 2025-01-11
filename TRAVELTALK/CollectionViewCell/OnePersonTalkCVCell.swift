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
        // 이미지뷰 설정
        userImageView.contentMode = .scaleAspectFill
        userImageView.clipsToBounds = true
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
        userImageView.backgroundColor = .systemGray6
        
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
        userImageView.image = UIImage(named: chatRoom.chatroomImage[0])
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
            
            let calendar = Calendar.current
            let now = Date()
            
            if calendar.isDateInToday(date) {
                dateFormatter.dateFormat = "HH:mm"
                return dateFormatter.string(from: date)
            }
            
            if calendar.component(.year, from: date) == calendar.component(.year, from: now) {
                dateFormatter.dateFormat = "MM/dd"
                return dateFormatter.string(from: date)
            }
            
            dateFormatter.dateFormat = "yyyy/MM/dd"
            return dateFormatter.string(from: date)
        }
    }
    
    // 날짜 포맷팅 헬퍼 메서드
    private func formatDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        
        let calendar = Calendar.current
        let now = Date()
        
        // 오늘 날짜인 경우 시간만 표시
        if calendar.isDateInToday(date) {
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: date)
        }
        
        // 올해인 경우 월/일 표시
        if calendar.component(.year, from: date) == calendar.component(.year, from: now) {
            dateFormatter.dateFormat = "MM/dd"
            return dateFormatter.string(from: date)
        }
        
        // 작년 이전인 경우 년/월/일 표시
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: date)
    }

