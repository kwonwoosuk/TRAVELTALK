//
//  ViewController.swift
//  TRAVELTALK
//
//  Created by 권우석 on 1/11/25.
//

import UIKit
// 날짜 표시 채팅 데이터로 이름 표시 최근 대화 표시
// 내일 꼭 완성해야한다...
class MainViewController: UIViewController {
    
    @IBOutlet weak var friends_SearchBar: UISearchBar!
    @IBOutlet weak var friendsCollectionView: UICollectionView!
    
    private let chatRoomArray = ChatRoom.mockChatList
    private var filteredChatRooms: [ChatRoom] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredChatRooms = chatRoomArray
        setupUI()
    }
    
    private func setupUI() {
        setupCollectionView()
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        friends_SearchBar.delegate = self
        friends_SearchBar.placeholder = "검색"
    }
    
    private func setupCollectionView() {
        friendsCollectionView.delegate = self
        friendsCollectionView.dataSource = self
        
        
        
        let onePersonXib = UINib(nibName: "OnePersonTalkCVCell", bundle: nil)
        friendsCollectionView.register(onePersonXib, forCellWithReuseIdentifier: OnePersonTalkCVCell.identifier)
        
        let twoPersonXib = UINib(nibName: "TwoPersonTalkCVCell", bundle: nil)
        friendsCollectionView.register(twoPersonXib, forCellWithReuseIdentifier: TwoPersonTalkCVCell.identifier)
        
        let threePersonXib = UINib(nibName: "ThreePersonTalkCVCell", bundle: nil)
        friendsCollectionView.register(threePersonXib, forCellWithReuseIdentifier: ThreePersonTalkCVCell.identifier)
        
        let fourPersonXib = UINib(nibName: "FourPersonTalkCVCell", bundle: nil)
        friendsCollectionView.register(fourPersonXib, forCellWithReuseIdentifier: FourPersonTalkCVCell.identifier)
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.itemSize = CGSize(width: view.frame.width, height: 110)
        friendsCollectionView.collectionViewLayout = layout
        
        
        friendsCollectionView.keyboardDismissMode = .interactive
    }
}


extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredChatRooms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let chatRoom = filteredChatRooms[indexPath.item]
        let imageCount = chatRoom.chatroomImage.count
        
        let cell: UICollectionViewCell
        
        switch imageCount {
        case 1:
            let onePersonCell = collectionView.dequeueReusableCell(withReuseIdentifier: OnePersonTalkCVCell.identifier, for: indexPath) as! OnePersonTalkCVCell
            onePersonCell.configure(with: chatRoom)
            cell = onePersonCell
            
        case 2:
            let twoPersonCell = collectionView.dequeueReusableCell(withReuseIdentifier: TwoPersonTalkCVCell.identifier, for: indexPath) as! TwoPersonTalkCVCell
            twoPersonCell.configure(with: chatRoom)
            cell = twoPersonCell
            
        case 3:
            let threePersonCell = collectionView.dequeueReusableCell(withReuseIdentifier: ThreePersonTalkCVCell.identifier, for: indexPath) as! ThreePersonTalkCVCell
            threePersonCell.configure(with: chatRoom)
            cell = threePersonCell
            
        case 4:
            let fourPersonCell = collectionView.dequeueReusableCell(withReuseIdentifier: FourPersonTalkCVCell.identifier, for: indexPath) as! FourPersonTalkCVCell
            fourPersonCell.configure(with: chatRoom)
            cell = fourPersonCell
            
        default:
            cell = UICollectionViewCell()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let chatVC = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController else { return }
        
        print(filteredChatRooms[indexPath.item])
        /*
         ChatRoom(chatroomId: 1, chatroomImage: ["Hue", "Jack", "Bran", "Den"], chatroomName: "도봉 멘토방", chatList: [TRAVELTALK.Chat(user: TRAVELTALK.User.hue, date: "2025-01-12 21:30", message: "열심히 일 하시고 계시는거죠?"), TRAVELTALK.Chat(user: TRAVELTALK.User.bran, date: "2025-01-12 22:32", message: "도봉 캠퍼스 가고싶어요..."), TRAVELTALK.Chat(user: TRAVELTALK.User.jack, date: "2025-01-12 22:38", message: "화이팅!!"), TRAVELTALK.Chat(user: TRAVELTALK.User.den, date: "2025-01-12 23:42", message: "열심히 하고 있습니다!!")])
         []
         ChatRoom(chatroomId: 2, chatroomImage: ["Hue"], chatroomName: "Hue", chatList: [TRAVELTALK.Chat(user: TRAVELTALK.User.hue, date: "2025-01-11 15:30", message: "열심히 공부하고 계시는거죠?"), TRAVELTALK.Chat(user: TRAVELTALK.User.user, date: "2025-01-11 15:48", message: "열심히는 하고있어요..."), TRAVELTALK.Chat(user: TRAVELTALK.User.user, date: "2025-01-11 15:49", message: "ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ...."), TRAVELTALK.Chat(user: TRAVELTALK.User.hue, date: "2025-01-12 21:30", message: "오...그러면... 내일 깃허브랑 블로그 전체 검사 진행 진행하도록 하겠습니다..."), TRAVELTALK.Chat(user: TRAVELTALK.User.hue, date: "2025-01-12 21:31", message: "화이팅 ^^")])
         [] 콘솔로 넘어가는거 확인 ... 어케 분리할건데?  */
        navigationController?.pushViewController(chatVC, animated: true)
    }
}


extension MainViewController: UISearchBarDelegate {// 사용자 검색기능... (추후에 대소문자 구별안하는거 넣기)
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredChatRooms = chatRoomArray
        } else {
            filteredChatRooms = chatRoomArray.filter { $0.isIncludedUserName(searchText) }
        }
        friendsCollectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
