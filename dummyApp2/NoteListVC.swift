import UIKit

class NoteListVC: UIViewController{
    

    private let searchController = UISearchController(searchResultsController: nil)
    private let tableView = UITableView()
    
    private let emptyStateLabel: UILabel = {
           let label = UILabel()
           label.text = "No notes yet.\nTap + to create one"
           label.numberOfLines = 2
           label.textAlignment = .center
           label.textColor = AppColors.subtitle
           label.font = .systemFont(ofSize: 16, weight: .regular)
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
    
    var notes:[Note] = []
    var filteredNotes:[Note] = []
    var currentNote:[Note]{
        return isSearching ? filteredNotes : notes
    }
    private var isSearching : Bool{
        return searchController.isActive &&
        !(searchController.searchBar.text?.isEmpty ?? true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notes = CoreDataManager.shared.fetchNotes()
        tableView.reloadData()
        updateEmptyState()
    }
    
    private func setupNav(){
        title = "My Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Notes"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(createTapped)
            )
        navigationItem.rightBarButtonItem?.tintColor = AppColors.primary
    }
    
    private func setupUI(){
        view.backgroundColor = AppColors.background
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.identifier)
        tableView.backgroundColor = AppColors.background
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        view.addSubview(emptyStateLabel)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    func updateEmptyState(){
        emptyStateLabel.isHidden = !currentNote.isEmpty
        tableView.isHidden = currentNote.isEmpty
    }
    @objc func createTapped(){
        let editorVC = NotesEditorVC()
        navigationController?.pushViewController(editorVC, animated: true)
    }
}
extension NoteListVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentNote.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.identifier, for: indexPath) as? NoteCell else{
            return UITableViewCell()
        }
        cell.configure(with: currentNote[indexPath.row])
        return cell
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let note = currentNote[indexPath.row]
            let editorVC = NotesEditorVC()
            editorVC.existingNote = note
            navigationController?.pushViewController(editorVC, animated: true)
        }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "delete"){ [weak self] _,_,_ in
            guard let self = self else {return}
            let notetodelete = self.currentNote[indexPath.row]
            CoreDataManager.shared.deleteNotes(note: notetodelete)
            self.notes.removeAll{$0 == notetodelete}
            self.filteredNotes.removeAll{$0 == notetodelete}
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.updateEmptyState()
        }
        delete.backgroundColor = AppColors.destructive
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

extension NoteListVC: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
                filteredNotes = notes.filter {
                    $0.title?.lowercased().contains(searchText.lowercased()) ?? false
                }
                tableView.reloadData()
                updateEmptyState()
    }
    
    
}
