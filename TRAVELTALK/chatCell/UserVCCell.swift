//
//  FriendsCellTableViewCell.swift
//  TRAVELTALK
//
//  Created by 권우석 on 1/12/25.
//

import UIKit

class UserVCCell: UITableViewCell {
    static let identifier = "UserVCCell"
    
   
    @IBOutlet weak var contentTextLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    func configureUI() {
        contentTextLabel.font = .systemFont(ofSize: 12)
        contentTextLabel.textAlignment = .left
        contentTextLabel.numberOfLines = 0
        contentTextLabel.layer.borderColor = UIColor.darkGray.cgColor
        contentTextLabel.layer.borderWidth = 1
        contentTextLabel.layer.cornerRadius = 8
        
        dateLabel.font = .systemFont(ofSize: 10)
        dateLabel.textAlignment = .center
        dateLabel.textColor = .lightGray
        
    }
    
    
    private func formatDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    
    func configureChat(row: Chat){
        
        
        contentTextLabel.text = row.message
        print(row.user.rawValue) // =User
        if let date = formatDate(row.date) {
            dateLabel.text = date
            
        }
        
    }
}
