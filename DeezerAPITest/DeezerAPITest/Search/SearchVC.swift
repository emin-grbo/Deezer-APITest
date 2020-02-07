//
//  ViewController.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 04/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import UIKit
import Combine

class SearchVC: UIViewController {

    // MARK: Variables ------------------------
    var viewModel: SearchViewModel
    var cancelable : AnyCancellable?
    
    var artists: [Artist]? { didSet {
        refreshViews()
        }}
    
    var coordinator: MainCoordinator
    let artistCell = String(describing: ArtistTableViewCell.self)
    
    // MARK: Outlets ------------------------
    @IBOutlet weak var noResultsLabel: UILabel! { didSet {
        noResultsLabel.text = "Oooops! No match!\nTry a different artist."
        noResultsLabel.textColor = .white
        noResultsLabel.alpha = 0
        }}
    @IBOutlet weak var searchBar: UISearchBar! { didSet {
        searchBar.delegate = self
        searchBar.stylize()
        }}
    @IBOutlet weak var tableView: UITableView! { didSet {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .background
        tableView.alpha = 0
        tableView.register(UINib(nibName: artistCell, bundle: nil), forCellReuseIdentifier: artistCell)
        }}
    
    // MARK: Initialization --------------------
    init(mainCoordinator: MainCoordinator, viewModel: SearchViewModel) {
        self.coordinator = mainCoordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    // ---------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
    }

    // MARK: Methods -------------------------------------
    func setupViews() {
        view.backgroundColor = .background
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func bindViewModel() {
        cancelable = viewModel.$artists
        .delay(for: .milliseconds(500), scheduler: DispatchQueue.main)
        .receive(on: DispatchQueue.main)
        .assign(to: \.artists, on: self)
    }
    
    func search() {
        tableView.showLoader()
        viewModel.term = searchBar.searchTextField.text ?? ""
    }
    
    func refreshViews() {
        DispatchQueue.main.async {
            // Reloading views
            self.tableView.reloadData()
            self.tableView.hideLoader()
            
            // Modifying visibility of tableView and no results Label
            if self.artists == nil {
                self.noResultsLabel.alpha = 0
                self.tableView.alpha = 0
            } else if self.artists?.isEmpty ?? true {
                self.noResultsLabel.alpha = 1
                self.tableView.alpha = 0
            } else {
                self.noResultsLabel.alpha = 0
                self.tableView.alpha = 1
            }
        }
    }
    
    // MARK: Keyboard Methods -----------------
    func addKeyboardNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            tableView.contentInset = .zero
        } else {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        tableView.scrollIndicatorInsets = tableView.contentInset
    }

}

// MARK: TableView delegate methods -----------------
extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: artistCell, for: indexPath) as! ArtistTableViewCell
        cell.artist = artists?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let selectedArtist = artists?[indexPath.row] else { return }
        coordinator.openAlbumsPage(for: selectedArtist)
    }
}

// MARK: SearchBar delegate methods -----------------
extension SearchVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search()
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search()
    }
}
