//
//  DetailAdvicesViewController.swift
//  floProject2
//
//  Created by Мария  on 4.12.22.
//

import UIKit

protocol DetailAdvicesDelegate: AnyObject {
    func saveToFavorites()
}

class DetailAdvicesViewController: UIViewController, UINavigationBarDelegate {
    
    
    var detailAdvicesTableView = UITableView(frame: .zero)
    var mainImage : String?
    var mainTitle : String?
    var descriptionOfAdvice : String?
    var isSaved : Bool =  false
    weak var delegate : DetailAdvicesDelegate?
    weak var adviceVC : AdvicesViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setConstraits()
        detailAdvicesTableView.delegate =  self
        detailAdvicesTableView.dataSource =  self
        setCells()
        setNavigationBar()
    }
//    MARK: Appearance customization
    private func setConstraits(){
        view.addSubview(detailAdvicesTableView)
        detailAdvicesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailAdvicesTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            detailAdvicesTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            detailAdvicesTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            detailAdvicesTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    private func setCells(){
        detailAdvicesTableView.register(FirstTableViewCell.nib, forCellReuseIdentifier: FirstTableViewCell.identifier)
        detailAdvicesTableView.register(SecondReviewTableViewCell.nib, forCellReuseIdentifier: SecondReviewTableViewCell.indentifier)
        detailAdvicesTableView.register(ThirdAdvicesTableViewCell.nib, forCellReuseIdentifier: ThirdAdvicesTableViewCell.identifier)
    }
   private func setNavigationBar(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "multiply")?.withTintColor(.black), style: .plain,target: self, action: #selector(dismissVC))
        self.navigationItem.rightBarButtonItem =  UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .done, target: self, action:#selector(saveToFavorites))
        self.title = "Советы"
    }
//MARK: OBJC METHODS
    @objc  private func dismissVC(){
        self.dismiss(animated: true) {
            print("vc is dismissed")
        }
    }
    @objc private func saveToFavorites(){
        self.isSaved.toggle()
        if isSaved == false {
            self.navigationItem.rightBarButtonItem?.image =  UIImage(systemName: SFSymbols.isNotSaved)
            // delete
        } else {
//            adviceVC?.delegate =  self
            guard mainTitle != nil && mainImage != nil else {return}
            adviceVC?.imageName =  self.mainImage
            adviceVC?.adviceTitle =  self.mainTitle
            delegate?.saveToFavorites()
            
            self.navigationItem.rightBarButtonItem?.image =  UIImage(systemName: SFSymbols.isSaved)
        }
    }
}
//MARK: Table View data source & delegate
extension DetailAdvicesViewController :  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 :
            guard let cell =  tableView.dequeueReusableCell(withIdentifier: FirstTableViewCell.identifier, for: indexPath) as? FirstTableViewCell else {
                return UITableViewCell()
            }
            cell.imageViewCell.image = UIImage(named: mainImage ?? "questionmark.square.dashed")
            cell.titleLabel.text = mainTitle
            return cell
        case 1 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondReviewTableViewCell.indentifier, for: indexPath) as? SecondReviewTableViewCell else {
                return UITableViewCell()
            }
            return cell
        default :
            guard let cell =  tableView.dequeueReusableCell(withIdentifier: ThirdAdvicesTableViewCell.identifier, for: indexPath) as? ThirdAdvicesTableViewCell else {
                return UITableViewCell()
            }
            cell.configure()
            cell.informationLabel.text =  descriptionOfAdvice
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0 :
            return self.view.bounds.height/3
        case 1:
            return 70
        case 2:
            return 150
        default :
            return 50
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0 :
            print(indexPath.row)
        case 1:
            guard let url =  URL(string: "https://flo.health/medical-expertise")else {return }
           presentSafariVC(with: url)
            print("1 case")
        default:
            print("OOPSSSSS ")
        }
    }
}


