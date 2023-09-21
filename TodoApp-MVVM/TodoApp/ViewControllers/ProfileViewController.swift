//
//  ProfileViewController.swift
//  TodoApp
//
//  Created by 김지은 on 2023/09/21.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "Menu"), style: .plain, target: self, action: #selector(leftButtonPressed(_:)))
        button.tintColor = .black
        return button
    }()
    
    lazy var imgProfile: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "circle")
        return image
    }()
    
    lazy var lbPost: UILabel = {
        let label = UILabel()
        label.text = "post"
        label.textAlignment = .center
        return label
    }()
    
    lazy var lbPostCnt: UILabel = {
        let label = UILabel()
        label.text = String(viewModel.todoList.count)
        label.textAlignment = .center
        return label
    }()
    
    lazy var stvPost: UIStackView = {
        let stackview = UIStackView()
        [lbPostCnt, lbPost].forEach {
            stackview.addArrangedSubview($0)
        }
        stackview.axis = .vertical
        stackview.distribution = .fillEqually
        return stackview
    }()
    
    lazy var lbFollower: UILabel = {
        let label = UILabel()
        label.text = "follower"
        label.textAlignment = .center
        return label
    }()
    
    lazy var lbFollowerCnt: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        return label
    }()
    
    lazy var stvFollower: UIStackView = {
        let stackview = UIStackView()
        [lbFollowerCnt, lbFollower].forEach {
            stackview.addArrangedSubview($0)
        }
        stackview.axis = .vertical
        stackview.distribution = .fillEqually
        return stackview
    }()
    
    lazy var lbFollowing: UILabel = {
        let label = UILabel()
        label.text = "following"
        label.textAlignment = .center
        return label
    }()
    
    lazy var lbFollowingCnt: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        return label
    }()
    
    lazy var stvFollowing: UIStackView = {
        let stackview = UIStackView()
        [lbFollowingCnt, lbFollowing].forEach {
            stackview.addArrangedSubview($0)
        }
        stackview.axis = .vertical
        stackview.distribution = .fillEqually
        return stackview
    }()
    
    lazy var svCnt: UIStackView = {
        let stackview = UIStackView()
        [stvPost, stvFollower, stvFollowing].forEach {
            stackview.addArrangedSubview($0)
        }
        stackview.distribution = .fillEqually
        return stackview
    }()
    
    lazy var svProfile: UIStackView = {
        let stackview = UIStackView()
        [imgProfile, svCnt].forEach {
            stackview.addArrangedSubview($0)
        }
        stackview.spacing = 44
        return stackview
    }()
    
    lazy var lbName: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var lbJob: UILabel = {
        let label = UILabel()
        label.text = "iOS Developer 🍎"
        return label
    }()
    
    lazy var lbLink: UILabel = {
        let label = UILabel()
        label.text = "www.naver.com"
        label.textColor = .blue
        label.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(linkLabelPressed(_:)))
        label.addGestureRecognizer(tapGestureRecognizer)
        return label
    }()
    
    lazy var btnFollow: UIButton = {
        let button = UIButton()
        button.setTitle("Follow", for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    lazy var btnMessage: UIButton = {
        let button = UIButton()
        button.setTitle("Message", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 0.5
        return button
    }()
    
    lazy var btnOpen: UIButton = {
        let button = UIButton()
        if let image = UIImage(named: "Vector 8") {
            button.setImage(image, for: .normal)
        }
        button.layer.borderWidth = 0.5
        return button
    }()
    
    lazy var stvManagement: UIStackView = {
        let stackview = UIStackView()
        [btnFollow, btnMessage].forEach {
            stackview.addArrangedSubview($0)
        }
        stackview.distribution = .fillEqually
        return stackview
    }()
    
    lazy var vMainButton: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var btnMain: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Grid"), for: .normal)
        return button
    }()
    
    lazy var cvMain: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return cv
    }()
    
    let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        
        view.backgroundColor = .white
        
        cvMain.delegate = self
        cvMain.dataSource = self
        cvMain.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
    }
    
    private func setLayout() {
        navigationItem.title = "Profile"
        navigationItem.leftBarButtonItem = leftButton
        
        view.addSubview(svProfile)
        view.addSubview(lbName)
        view.addSubview(lbJob)
        view.addSubview(lbLink)
        view.addSubview(stvManagement)
        view.addSubview(btnOpen)
        view.addSubview(cvMain)
        
        svProfile.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(14)
            $0.leading.equalTo(view).offset(14)
            $0.trailing.equalTo(view).offset(-14)
        }
        
        imgProfile.snp.makeConstraints {
            $0.width.height.equalTo(88)
        }
        
        lbName.snp.makeConstraints {
            $0.top.equalTo(svProfile.snp.bottom).offset(14)
            $0.leading.equalTo(view).offset(15)
            $0.trailing.equalTo(view).offset(-15)
        }
        
        lbJob.snp.makeConstraints {
            $0.top.equalTo(lbName.snp.bottom).offset(2)
            $0.leading.equalTo(view).offset(15)
            $0.trailing.equalTo(view).offset(-15)
        }
        
        lbLink.snp.makeConstraints {
            $0.top.equalTo(lbJob.snp.bottom).offset(0)
            $0.leading.equalTo(view).offset(15)
            $0.trailing.equalTo(view).offset(-15)
        }
        
        stvManagement.snp.makeConstraints {
            $0.top.equalTo(lbLink.snp.bottom).offset(11)
            $0.leading.equalTo(view).offset(15)
            $0.height.equalTo(30)
        }
        
        btnOpen.snp.makeConstraints {
            $0.leading.equalTo(stvManagement.snp.trailing).offset(7)
            $0.height.width.equalTo(30)
            $0.centerY.equalTo(stvManagement)
            $0.trailing.equalTo(view).offset(-15)
        }
        
        cvMain.snp.makeConstraints {
            $0.top.equalTo(stvManagement.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalTo(view)
        }
    }
    
    @objc func leftButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "CustomSideMenuNavigation") as? CustomSideMenuNavigation {
            present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func linkLabelPressed(_ sender: UITapGestureRecognizer) {
        guard let url = URL(string: "https://www.naver.com") else {
            return
        }
        UIApplication.shared.open(url, options: [:])
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.todoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        let dataDecoded : Data = Data(base64Encoded: viewModel.todoList[indexPath.row].image, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        cell.imgMain.image = decodedimage
        return cell
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    // 위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // cell 사이즈( 옆 라인을 고려하여 설정 )
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 3 - 1 ///  3등분하여 배치, 옆 간격이 1이므로 1을 빼줌
        print("collectionView width=\(collectionView.frame.width)")
        print("cell하나당 width=\(width)")
        print("root view width = \(self.view.frame.width)")
        
        let size = CGSize(width: width, height: width)
        return size
    }
}

class CollectionViewCell: UICollectionViewCell {
    lazy var imgMain: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        self.addSubview(imgMain)
        
        imgMain.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }
}
