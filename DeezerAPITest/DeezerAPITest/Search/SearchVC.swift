//
//  ViewController.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 04/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import UIKit
import Combine

class SearchViewModel {
    @Published var artists : [Artist]?
    var term : String! { didSet {
        getArtists()
        }}
    
    func getArtists() {
        ApiService.searchArtists(term) { (result: (Result<ApiResponse<Artist>, APIError>)) in
            switch result {
            case .success(let response):
                self.artists = response.data == nil ? [Artist]() : response.data
            case .failure(let error):
                print(error)
            }
        }
    }
}

class SearchVC: UIViewController {

    var viewModel: SearchViewModel
    var cancelable : AnyCancellable?
    
    var artists: [Artist]? { didSet {
        refreshViews()
        }}
    
    var mainCoordinator: MainCoordinator
    let artistCell = String(describing: ArtistTableViewCell.self)
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        bindViewModel()
    }

    // MARK: Initialization
    init(mainCoordinator: MainCoordinator, viewModel: SearchViewModel) {
        self.mainCoordinator = mainCoordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    func search() {
        tableView.showLoader()
        viewModel.term = searchBar.searchTextField.text ?? ""
    }
    
    func bindViewModel() {
        cancelable = viewModel.$artists
        .delay(for: .milliseconds(500), scheduler: DispatchQueue.main)
        .receive(on: DispatchQueue.main)
        .assign(to: \.artists, on: self)
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

}


extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: artistCell, for: indexPath) as! ArtistTableViewCell
        cell.artistImage.image = nil
        cell.artistName.text = artists?[indexPath.row].name
        cell.artistImage.fromUrl(artists?[indexPath.row].pictureXl ?? "")

        // Selection color
        let bgColorView = UIView()
        bgColorView.backgroundColor = .black
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("selected")
    }
}

extension SearchVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search()
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search()
    }
}
