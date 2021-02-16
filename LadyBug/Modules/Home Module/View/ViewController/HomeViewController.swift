//
//  HomeViewController.swift
//  LadyBug
//
//  Created by Sameh on 2/15/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var headerView: HomeHeaderView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addPostButton: UIButton!
    
    //Attribuites
    private var presnter: HomePresenterProtocol!
    private let images = HomeImages()
    
    init() {
        super.init(nibName: "\(HomeViewController.self)", bundle: nil)
        presnter = HomePresenter(view: self)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        presnter.attach()
    }
    
}

// MARK:- UI Setup
extension HomeViewController {
    private func setupUI() {
        setupNaviagtionBarUI()
        addSearchBarToNaviagtionBar()
        addBarButtonsToNavigationBar()
        setupHeaderView()
        registerTableViewCell()
        setupTableViewRowHeight()
        setupAddPostButton()
    }
    
    private func setupNaviagtionBarUI() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func addSearchBarToNaviagtionBar() {
        let searchBar = UISearchBar()
        searchBar.setImage(UIImage(named: images.search), for: .search, state: .normal)
        searchBar.barTintColor = .paleGrey
        searchBar.tintColor = .black
        navigationItem.titleView = searchBar
        
        let attributes = NSAttributedString(string: presnter.localizer.searchPlaceHolder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.cloudyBlue, NSAttributedString.Key.font: UIFont.get(enFont: .regular(13), arFont: .regular(13))])
        
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.attributedPlaceholder = attributes
        } else {
           let searchField = searchBar.value(forKey: "searchField") as? UITextField
           searchField?.attributedPlaceholder = attributes
        }
    }
    
    private func addBarButtonsToNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: images.ladyBug), style: .plain, target: nil, action: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: images.nofication), style: .plain, target: nil, action: nil)
    }
    
    private func setupHeaderView() {
        headerView.attach(delegate: presnter)
        headerView.notifyDatasourceChanged()
    }
    
    private func registerTableViewCell() {
        let nib = UINib(nibName: "\(HomePostsCell.self)", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "\(HomePostsCell.self)")
    }
    
    private func setupTableViewRowHeight() {
        tableView.estimatedRowHeight = 351.0
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupAddPostButton() {
        addPostButton.setTitle(presnter.localizer.addPost, for: .normal)
        addPostButton.titleLabel?.font = UIFont.get(enFont: .regular(12), arFont: .regular(12))
    }
}

extension HomeViewController: HomeViewProtocol {
    func notifyHeaderViewDatasourceChanged() {
        headerView.notifyDatasourceChanged()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presnter.postsDatasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(HomePostsCell.self)", for: indexPath) as? HomePostsCell ?? HomePostsCell()
        cell.setupUI(localizer: presnter.localizer)
        return cell
    }
}
