//
//  CharactersListViewModel.swift
//  SingKingTechnicalTask
//
//  Created by Abdalah on 03/10/2022.
//

import Foundation
class CharactersListViewModel {
    // i  do  ApiServiceProtocol  to Dependency Injection
    let apiService : ApiServiceProtocol
    
    // charactersInfoData   is array of DataSource to append data it
    private  var charactersInfoData = [CharactersNameInfo]()
    var filteredData = [CharactersListCellViewModel]()
    var vms = [CharactersListCellViewModel]()
    
    private var cellViewModel : [CharactersListCellViewModel] = [CharactersListCellViewModel](){
        didSet{
            self.reloadTableViewClouser?()
        }
    }
    
    var reloadTableViewClouser :(()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    init(apiService : ApiServiceProtocol = ApiService()) {
        self.apiService = apiService
    }
    
    //    // callback for interfaces
    
    var numberOfCell :Int {
        print(cellViewModel.count)
        return cellViewModel.count
    }
    
    var numberOfCellSearch :Int {
        return filteredData.count
    }
    
    var state: State = .empty {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    
    func initFetchData(){
        
        apiService.getCharactersListInfo {[weak self] result in
            guard let self = self else{return}
            switch result {
            case .success(let response):
                
                // self.book = response.feed?.results ?? []
                self.processFetchedCharactersList(charactersInfo: response)
                self.state = .populated
                
            case .failure(let error):
                self.state = .error
                self.alertMessage = error.rawValue
                
            }
        }
        
    }
    
    func searchArticle(searchText:String){
        filteredData = cellViewModel
        filteredData = cellViewModel.filter({ $0.name.contains(searchText.lowercased())})
        filteredData = cellViewModel.filter({ $0.name.contains(searchText.uppercased())})
        self.reloadTableViewClouser?()
        
    }
    
    func getCellViewModel(at indexPath : IndexPath) -> CharactersListCellViewModel{
        return cellViewModel[indexPath.item]
    }
    
    func getCellViewModelSearch(at indexPath : IndexPath) -> CharactersListCellViewModel{
        return filteredData[indexPath.item]
    }
    
    
    func createCellViewModel( characters: CharactersNameInfo ) -> CharactersListCellViewModel {
        let name = characters.name
        let image = characters.img
        return CharactersListCellViewModel(image:image ?? "", name: name ?? "")
    }
    
    private func processFetchedCharactersList( charactersInfo: [CharactersNameInfo] ) {
        self.charactersInfoData = charactersInfo // Cache
        for characters in charactersInfo {
            vms.append( createCellViewModel(characters: characters) )
            
        }
        self.cellViewModel = vms
    }
    
    
    
    
}
