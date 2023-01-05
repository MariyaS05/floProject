//
//  AdvicesViewController.swift
//  floProject2
//
//  Created by Мария  on 12.11.22.
//

import UIKit
protocol AdvicesDelegate: AnyObject {
    func didAllAdvicesButtonTapped()
    func didFavoritesAdvicesButtonTapped()
}

class AdvicesViewController: UIViewController {
    
    enum Section : Hashable {
        case main
    }
    var buttonAllAdvices = AllAdvicesButton(title: "Все советы")
    var buttonFavoritesAdvices =  FavoritesAdvicesButton(title: "Сохраненное")
    var advicesSection = AllAdvices()
    var favoritesAdvices : [Advice] = []
    var mainCollectionView : UICollectionView!
    var dataSource : UICollectionViewDiffableDataSource<AdvicesType,Advice>?
    var dataSourceFavorites : UICollectionViewDiffableDataSource <Section, Advice>?
    let padding : CGFloat =  10
    static var isSelected : Bool =  true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        setupCollectionView()
        createDataSource()
        reloadData()
        setNavigationbar()
    }
    private func setupButtons(){
        let height : CGFloat =  35
        
        view.addSubview(buttonAllAdvices)
        view.addSubview(buttonFavoritesAdvices)
        buttonAllAdvices.delegate =  self
        buttonFavoritesAdvices.delegate =  self
        
        NSLayoutConstraint.activate([
            buttonAllAdvices.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            buttonAllAdvices.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            buttonAllAdvices.heightAnchor.constraint(equalToConstant: height),
            buttonAllAdvices.widthAnchor.constraint(equalToConstant: 120),
            
            buttonFavoritesAdvices.topAnchor.constraint(equalTo: buttonAllAdvices.topAnchor),
            buttonFavoritesAdvices.leadingAnchor.constraint(equalTo: buttonAllAdvices.trailingAnchor, constant: padding),
            buttonFavoritesAdvices.heightAnchor.constraint(equalToConstant: height),
            buttonFavoritesAdvices.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    private func setupCollectionView(){
        switch AdvicesViewController.isSelected {
        case true:
            mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        case false:
            mainCollectionView =  UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createTwoColumnFlowLayout(in: view))
        }
        mainCollectionView.translatesAutoresizingMaskIntoConstraints = false
        mainCollectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        view.addSubview(mainCollectionView)
        
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: buttonAllAdvices.bottomAnchor, constant: 4),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        mainCollectionView.register(AdvicesCell.self, forCellWithReuseIdentifier: AdvicesCell.reuseId)
        mainCollectionView.register(HeaderViewAdvicesVC.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderViewAdvicesVC.reuseId)
        mainCollectionView.register(ButtonFavoritesAdvices.self, forCellWithReuseIdentifier: ButtonFavoritesAdvices.reuseId)
        mainCollectionView.register(ButtonsAdvicesCollectionViewCell.self, forCellWithReuseIdentifier: ButtonsAdvicesCollectionViewCell.reuseId)
        mainCollectionView.translatesAutoresizingMaskIntoConstraints =  false
        mainCollectionView.delegate =  self
    }
   
    private func createLayout()->UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnviroment in
            _ = AdvicesType.allCases[sectionIndex]
//            switch sectionIndex {
//            case 0 :
//                return self.createButtonSection()
//            default:
                return self.createSection()
//            }
        }
        return layout
    }
    private func createDataSoureFavoritesFollowers(){
        dataSourceFavorites =   UICollectionViewDiffableDataSource<Section,Advice>(collectionView: mainCollectionView, cellProvider: { collectionView, indexPath, advice in
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdvicesCell.reuseId, for: indexPath) as? AdvicesCell
            cell?.configure(with: advice)
            cell?.configureTitle(with: advice)
            return cell
        })
    }
    private func createDataSource(){
        dataSource = UICollectionViewDiffableDataSource<AdvicesType,Advice>(collectionView: mainCollectionView, cellProvider: { collectionView, indexPath, advice  in
                let cell  =  collectionView.dequeueReusableCell(withReuseIdentifier: AdvicesCell.reuseId, for: indexPath) as? AdvicesCell
                cell?.configure(with: advice)
                cell?.configureTitle(with: advice)
                return cell
        })
        dataSource?.supplementaryViewProvider = {(collectionView, kind, indexPath) in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderViewAdvicesVC.reuseId, for: indexPath) as? HeaderViewAdvicesVC
            switch indexPath.section {
            case 0 :
                header?.configure(with: HeaderLabel.menstrualCycle)
            case 1 :
                header?.configure(with: HeaderLabel.basicOfFood)
            case 2 :
                header?.configure(with: HeaderLabel.beautySecrets)
            case 3 :
                header?.configure(with: HeaderLabel.cycleWorkaut)
            case 4 :
                header?.configure(with: HeaderLabel.healthySleep)
            case 5 :
                header?.configure(with: HeaderLabel.healthyWeight)
            case 6 :
                header?.configure(with: HeaderLabel.harmony)
            case 7 :
                header?.configure(with: HeaderLabel.reproductiveHealth)
            default:
                header?.configure(with: "")
            }
            return header
        }
    }
    private func reloadData(){
        var snapshot = NSDiffableDataSourceSnapshot<AdvicesType,Advice>()
        for i in advicesSection.sections {
            snapshot.appendSections([i.type])
            snapshot.appendItems(i.items, toSection: i.type)
        }
        dataSource?.applySnapshotUsingReloadData(snapshot)
    }
    private func reloadDataWithFavoritesAdvices(for advices : [Advice]){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Advice>()
        snapshot.appendSections([.main])
        snapshot.appendItems(advices)
        dataSourceFavorites?.apply(snapshot)
    }
    private func addStandardHeader(toSection section: NSCollectionLayoutSection) {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [headerElement]
    }
//    private func createButtonSection ()-> NSCollectionLayoutSection  {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
//        let item  =  NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 8)
//        let groupSize =  NSCollectionLayoutSize(widthDimension: .estimated(120), heightDimension: .estimated(35))
//        let group  = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: padding, bottom: 0, trailing: padding)
//        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
//        return section
//    }
    private func createSection()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: padding)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(180), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section =  NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: padding, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        addStandardHeader(toSection: section)
        return section
    }
    func setNavigationbar(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: SFSymbols.notifications), style: .plain, target: self, action: #selector(goToNotifications))
        self.navigationItem.leftBarButtonItem =  UIBarButtonItem(image: UIImage(systemName: SFSymbols.personalProfile), style: .plain, target: self, action: #selector(returnToSettings))
        self.editButtonItem.tintColor = .black
        self.tabBarItem = tabBarItem
    }
    
    @objc public func returnToSettings (){
        let vc = SettingsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc public func goToNotifications (){
        let vc = NotificationsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension AdvicesViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailAdvicesViewController()
        let navVC =  UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        self.navigationController?.present(navVC, animated: true)
        vc.advices = self.advicesSection
        vc.mainImage =  self.advicesSection.sections[indexPath.section].items[indexPath.row].imageName
        vc.mainTitle = self.advicesSection.sections[indexPath.section].items[indexPath.row].title
    }
}
extension AdvicesViewController : AdvicesDelegate {
    func didAllAdvicesButtonTapped() {
        createDataSource()
        reloadData()
        print("AllAdvices is tapped")
    }
    func didFavoritesAdvicesButtonTapped() {
        AdvicesViewController.isSelected  =  false
        createDataSoureFavoritesFollowers()
//        reloadDataWithFavoritesAdvices(for: favoritesAdvices)
        print("FavoritesAdvicesTapped")
    }
}
