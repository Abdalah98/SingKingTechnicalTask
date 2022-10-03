//
//  CharactersListVC.swift
//  SingKingTechnicalTask
//
//  Created by Abdalah on 03/10/2022.
//

import UIKit

class CharactersListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var searching = false
    let searchController = UISearchController()
    var charactersListTableViewCell = "CharactersListTableViewCell"
    
    lazy var charactersListViewModel: CharactersListViewModel =
    {
        return CharactersListViewModel()
    }()
    
    
    let activity: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView()
        aiv.style = .large
        aiv.color = .label
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initVM()
        view.addSubview(activity)
    }
    func stopActivity(){
        self.activity.stopAnimating()
        self.activity.hidesWhenStopped = true
    }
    // fetch data
    // fetch data when binding with Closure
    func initVM(){
        showAlert()
        updateLoadingStatus()
        reloadTableView()
        charactersListViewModel.initFetchData()
        configureNIBCell()
        tableViewDesign()
        configureSearch()
    }
    
    
    // MARK: - Table view data source
    func configureNIBCell(){
        let nib = UINib(nibName: charactersListTableViewCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: charactersListTableViewCell)
    }
    
    func tableViewDesign() {
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView .dataSource = self
    }

    ///  show Alert Closure : when get error or happen something show me error in Alert extension
    fileprivate func showAlert() {
                charactersListViewModel.showAlertClosure =  {[weak self] in ()
                    DispatchQueue.main.async {
                        if let message = self?.charactersListViewModel.alertMessage  {
                            self?.showAlert(withTitle: "", withMessage: message)
                        }
                    }
                }
    }
    // updateLoadingStatus: when call data i show loading Activity when i fetch all data  it hidden or when something error it hide and show it data downloading
    // animate when collection show it
    fileprivate func  updateLoadingStatus() {
        charactersListViewModel.updateLoadingStatus = { [weak self] () in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                switch self.charactersListViewModel.state {
                case .empty, .error:
                     self.stopActivity()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.tableView.alpha = 0.0
                    })
                case .loading:
                     self.activity.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.tableView.alpha = 0.0
                    })
                case .populated:
                      self.stopActivity()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.tableView.alpha = 1.0
                    })
                }
            }
        }
    }
    // reloadTableViewClouser:  reload data when it comes to show in reloadTableViewClouser and fetch data
    fileprivate func reloadTableView() {
        charactersListViewModel.reloadTableViewClouser = {[weak self] in ()
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    //add search in navigationItem
    fileprivate func configureSearch() {
        searchController.searchBar.placeholder = "Search Here"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
}


extension CharactersListVC : UITableViewDataSource , UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return charactersListViewModel.numberOfCellSearch
        }else {
            return charactersListViewModel.numberOfCell
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: charactersListTableViewCell, for: indexPath) as? CharactersListTableViewCell else{
            fatalError("Not found cell identifier")
        }
        let cellVM = charactersListViewModel.getCellViewModel(at: indexPath)
        cell.characters = cellVM
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


extension CharactersListVC :UISearchBarDelegate, UISearchControllerDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            searching = false
        }else{
            searching = true
            charactersListViewModel.searchArticle(searchText: searchText)
            reloadTableView()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
         initVM()
    }
}
