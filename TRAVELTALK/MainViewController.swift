//
//  ViewController.swift
//  TRAVELTALK
//
//  Created by 권우석 on 1/11/25.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var friends_SearchBar: UISearchBar!
    @IBOutlet weak var friendsCollectionView: UICollectionView!
    
    let chatRoomArray: [ChatRoom] = ChatRoom.mockChatList
    var searchedChatRoomArray : [ChatRoom] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchedChatRoomArray = chatRoomArray
        configureView()
        print(chatRoomArray)
    }
    // MARK: - View설정
    func configureView() {
        friendsCollectionView.delegate = self // 둘다 먼저 해주고 시작!
        friendsCollectionView.dataSource = self // 너 dataSource라는 부하 있어
        friends_SearchBar.delegate = self // searchBar도 니 부하야
        friends_SearchBar.placeholder = "검색"
        friends_SearchBar.searchTextField.textAlignment = .left
        
        // MARK: - 컬렉션뷰 Cell등록
        let onePersonXib = UINib(nibName: OnePersonTalkCVCell.identifier, bundle: nil)
        friendsCollectionView.register(onePersonXib, forCellWithReuseIdentifier: OnePersonTalkCVCell.identifier)
        
        let twoPersonXib = UINib(nibName: TwoPersonTalkCVCell.identifier, bundle: nil)
        friendsCollectionView.register(twoPersonXib, forCellWithReuseIdentifier: TwoPersonTalkCVCell.identifier)
        
        let threePersonXib = UINib(nibName: ThreePersonTalkCVCell.identifier, bundle: nil)
        friendsCollectionView.register(threePersonXib, forCellWithReuseIdentifier: ThreePersonTalkCVCell.identifier)
        
        let fourPersonXib = UINib(nibName: FourPersonTalkCVCell.identifier, bundle: nil)
        friendsCollectionView.register(fourPersonXib, forCellWithReuseIdentifier: FourPersonTalkCVCell.identifier)
        
        // MARK: - Cell Layout설정
        let deviceWidth: CGFloat = view.window?.windowScene?.screen.bounds.width ?? UIScreen.main.bounds.width // 아이폰에서만 사용가능 아이폰의 가로에 맞춰줌 아이패드 안됨 스플릿뷰라는 친구덕에
        let layout = UICollectionViewFlowLayout()
        let minimumSpacing: CGFloat = 10
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: deviceWidth, height: 78)
        layout.minimumLineSpacing = minimumSpacing
        layout.sectionInset = UIEdgeInsets(top: minimumSpacing , left: 0, bottom: minimumSpacing, right: 0)
        friendsCollectionView.collectionViewLayout = layout
        friendsCollectionView.keyboardDismissMode = .interactive // 스크롤에 따라 키보드가 움직이며 사라진다!
        
        
        
        
    }
    
    
    
    
}
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    //섹션 몇개로 할래~?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchedChatRoomArray.count
    }
    
   
    
    // 셀 디자인 어떻게 할까~?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let imageCount: Int = searchedChatRoomArray[indexPath.item].chatroomImage.count
        //  단톡인지 아닌지 알 방법이 chatroomImage: [User.hue.profileImage, User.jack.profileImage, User.bran.profileImage, User.den.profileImage] 배열의 갯수
        
        
        let identifier: String = switch imageCount {
        case 1: OnePersonTalkCVCell.identifier
        case 2: TwoPersonTalkCVCell.identifier
        case 3: ThreePersonTalkCVCell.identifier
        case 4: FourPersonTalkCVCell.identifier
        default: OnePersonTalkCVCell.identifier
        }
        //아이덴티 파이어에 따라서 셀을 다르게 리턴해주고 싶은데...
        if identifier == OnePersonTalkCVCell.identifier {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? OnePersonTalkCVCell else { return UICollectionViewCell() }
            
            return cell
        } else if identifier == TwoPersonTalkCVCell.identifier {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? TwoPersonTalkCVCell else { return UICollectionViewCell() }
            return cell
        } else if identifier == ThreePersonTalkCVCell.identifier {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? ThreePersonTalkCVCell else { return UICollectionViewCell() }
            return cell
        } else if identifier == FourPersonTalkCVCell.identifier {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? FourPersonTalkCVCell else { return UICollectionViewCell() }
            return cell
        }// 너무 더러운데
        
        
        
        return UICollectionViewCell()
    }
    
    // 눌렸을때 어쩔래~?
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(
            withIdentifier: "ChatViewController"
        ) as? ChatViewController else { return }
        
        vc.chatRoom = searchedChatRoomArray[indexPath.item]  // 내용전부를 다음화면으로 넘겨주고 다음화면에서 잘 분리해서 사용해보자!
        
        navigationController?.pushViewController(vc, animated: true)
    }
}



extension MainViewController: UISearchBarDelegate {
    
    func searchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            return searchedChatRoomArray = chatRoomArray
        }
        searchedChatRoomArray = chatRoomArray.filter { $0.isIncludedUserName(searchText) }
    }
    
    
}
