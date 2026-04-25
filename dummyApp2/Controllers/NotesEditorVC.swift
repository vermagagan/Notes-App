import UIKit

class NotesEditorVC: UIViewController {

    var existingNote: Note? = nil
    private let titleField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Title"
        tf.font = .systemFont(ofSize: 18, weight: .bold)
        tf.borderStyle = .none
        tf.textColor = AppColors.header
        tf.attributedPlaceholder = NSAttributedString(
            string: "Enter Title",
            attributes: [.foregroundColor : AppColors.placeholder])
        tf.backgroundColor = .clear
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    private var bodyField: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = .systemFont(ofSize: 16)
        tv.textColor = AppColors.header
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        return tv
    }()
    private let divider : UIView = {
        let dividerView = UIView()
        dividerView.backgroundColor = AppColors.divider
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        return dividerView
    }()

    private let charCountLabel: UILabel = {
            let label = UILabel()
            label.text = "0 characters"
            label.font = .systemFont(ofSize: 11, weight: .regular)
            label.textColor = AppColors.subtitle
            label.textAlignment = .right
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupnavBar()
        setupLayout()
        editModeIfNeeded()
        bodyField.delegate = self
    }
    private func setupnavBar(){
        title = existingNote == nil ? "New Note" : "Edit Note"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveTapped)
            )
        navigationItem.rightBarButtonItem?.tintColor = AppColors.primary
    }
    private func setupLayout(){
        view.backgroundColor = AppColors.background
        
        view.addSubview(titleField)
        view.addSubview(divider)
        view.addSubview(bodyField)
        view.addSubview(charCountLabel)
        
        NSLayoutConstraint.activate([
            titleField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                        titleField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                        titleField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

                        // Divider
                        divider.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 12),
                        divider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                        divider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                        divider.heightAnchor.constraint(equalToConstant: 1),

                        // Body field
                        bodyField.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 12),
                        bodyField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                        bodyField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                        bodyField.bottomAnchor.constraint(equalTo: charCountLabel.topAnchor, constant: -8),

                        // Char count
                        charCountLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
                        charCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

    }
    
     private func editModeIfNeeded(){
        guard let note = existingNote else {return}
        titleField.text = note.title
        bodyField.text = note.body
        updateCharCount()
    }
    
    private func updateCharCount(){
        let count = bodyField.text.count
        charCountLabel.text = "\(count) characters"
    }
    
    @objc private func saveTapped(){
        guard let titleText = titleField.text, !titleText.isEmpty else{
            print("Title cannot be empty")
            return
        }
        let bodyText = bodyField.text ?? ""
        
        
        if let note = existingNote{
            CoreDataManager.shared.updateNotes(note: note, newtitle: titleText, newbody: bodyText)

        }
        else{
            CoreDataManager.shared.createNotes(title: titleText, description: bodyText)
        }
        navigationController?.popViewController(animated: true)
    }
}
extension NotesEditorVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateCharCount()
    }
}
