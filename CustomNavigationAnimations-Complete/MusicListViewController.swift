//
//  MusicListViewController.swift
//  CustomNavigationAnimations-Complete
//
//  Created by Thành Lã on 11/20/18.
//  Copyright © 2018 Sam Stone. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static var main: UIStoryboard   { return UIStoryboard(name: "Main", bundle: nil) }
    
    func controller<C: UIViewController>(of type: C.Type) -> C {
        return self.instantiateViewController(withIdentifier: String(describing: type)) as! C
    }
}

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configTransparentNavigationBar()
    }
    
    func configTransparentNavigationBar() {
        var titleTextAttributes: [NSAttributedString.Key: Any] = [.foregroundColor : UIColor.darkText]
        if #available(iOS 8.2, *) {
            titleTextAttributes[.font] = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.semibold)
        }
        navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
        navigationController?.navigationBar.tintColor = UIColor.gray.withAlphaComponent(0.7)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
}

class MusicListViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    private var selectedSong : Song?
    
    private var selectedFrame : CGRect?
    private var customInteractor : CustomInteractor?
    
    private var songs: [Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        songs = (1...5).map({ _ in Song.mockup }).flatMap({ $0 })
        
    }

    @IBAction func stop(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension MusicListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        cell.imageView?.image = song.artwork
        cell.textLabel?.text = song.title
        cell.detailTextLabel?.text = song.artist
        return cell
    }
}

extension MusicListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath), let frame = cell.imageView?.frame {
            selectedFrame = tableView.convert(cell.convert(frame, to: tableView), to: tableView.superview)
        }
        
        selectedSong = songs[indexPath.row]
        
        let playingVC = UIStoryboard.main.controller(of: MusicPlayerViewController.self)
        playingVC.song = selectedSong
        navigationController?.pushViewController(playingVC, animated: true)
    }
}

extension MusicListViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let ci = customInteractor else { return nil }
        return ci.transitionInProgress ? customInteractor : nil
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationControllerOperation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let frame = self.selectedFrame else { return nil }
        guard let song = self.selectedSong else { return nil }
        
        let duration = TimeInterval(UINavigationControllerHideShowBarDuration)
        
        switch operation {
        case .push:
            self.customInteractor = CustomInteractor(attachTo: toVC)
            return CustomAnimator(duration: duration, isPresenting: true, originFrame: frame, image: song.artwork)
        default:
            return CustomAnimator(duration: duration, isPresenting: false, originFrame: frame, image: song.artwork)
        }
    }
}
