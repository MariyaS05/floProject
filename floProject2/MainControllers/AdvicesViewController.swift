//
//  AdvicesViewController.swift
//  floProject2
//
//  Created by Мария  on 12.11.22.
//

import UIKit
protocol AdvicesDelegate {
    func didAllAdvicesButtonTapped()
    func didFavoritesAdvicesButtonTapped()
}

class AdvicesViewController: UIViewController {
    
    
    var advicesSection = AllAdvices()
    var mainCollectionView : UICollectionView!
    var dataSource : UICollectionViewDiffableDataSource<AdvicesType,Advice>?
    let padding : CGFloat =  10
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupCollectionView()
        createDataSource()
        reloadData()
        setNavigationbar()
    
    }
    private func setupCollectionView(){
       
        mainCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createLayout())
        mainCollectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        view.addSubview(mainCollectionView)
        mainCollectionView.register(AdvicesCell.self, forCellWithReuseIdentifier: AdvicesCell.reuseId)
        mainCollectionView.register(HeaderViewAdvicesVC.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderViewAdvicesVC.reuseId)
        mainCollectionView.register(ButtonsAdvicesCollectionViewCell.self, forCellWithReuseIdentifier: ButtonsAdvicesCollectionViewCell.reuseId)
        mainCollectionView.translatesAutoresizingMaskIntoConstraints =  false
        mainCollectionView.delegate =  self
    }
    private func createLayout()->UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnviroment in
            _ = AdvicesType.allCases[sectionIndex]
            switch sectionIndex {
            case 0 :
                return self.createButtonSection()
            default:
                return self.createSection()
            }
        }
        return layout
    }
    private func createDataSource(){
        dataSource = UICollectionViewDiffableDataSource<AdvicesType,Advice>(collectionView: mainCollectionView, cellProvider: { collectionView, indexPath, advice  in
            switch self.advicesSection.sections[indexPath.section].type{
            case .buttons :
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonsAdvicesCollectionViewCell.reuseId, for: indexPath) as? ButtonsAdvicesCollectionViewCell
                cell?.configure(with: advice)
                return cell
            default:
                let cell  =  collectionView.dequeueReusableCell(withReuseIdentifier: AdvicesCell.reuseId, for: indexPath) as? AdvicesCell
                cell?.configure(with: advice)
                cell?.configureTitle(with: advice)
                return cell
            }
        })
        dataSource?.supplementaryViewProvider = {(collectionView, kind, indexPath) in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderViewAdvicesVC.reuseId, for: indexPath) as? HeaderViewAdvicesVC
            switch indexPath.section {
            case 0 :
                return nil
            case 1 :
                header?.configure(with: HeaderLabel.menstrualCycle)
            case 2 :
                header?.configure(with: HeaderLabel.basicOfFood)
            case 3 :
                header?.configure(with: HeaderLabel.beautySecrets)
            case 4 :
                header?.configure(with: HeaderLabel.cycleWorkaut)
            case 5 :
                header?.configure(with: HeaderLabel.healthySleep)
            case 6 :
                header?.configure(with: HeaderLabel.healthyWeight)
            case 7 :
                header?.configure(with: HeaderLabel.harmony)
            case 8 :
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
    private func addStandardHeader(toSection section: NSCollectionLayoutSection) {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [headerElement]
    }
    private func createButtonSection ()-> NSCollectionLayoutSection  {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item  =  NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 8)
        let groupSize =  NSCollectionLayoutSize(widthDimension: .estimated(120), heightDimension: .estimated(35))
        let group  = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: padding, bottom: 0, trailing: padding)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        return section
    }
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
        print("all advices button tapped")
    }
    
    func didFavoritesAdvicesButtonTapped() {
        print("favorites advices button tapped")
    }
}
