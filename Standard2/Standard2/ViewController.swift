//
//  ViewController.swift
//  Standard2
//
//  Created by 윤채영 on 2022/09/27.
//
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var productLabel: UILabel!
    
    private let segmentedControl: UISegmentedControl = {
    let segmentedControl = UnderlineSegmentedControl(items: ["상품(1)", "브랜드(0)", "판매자(0)"])
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    return segmentedControl
  }()
  private let childView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  private let vc1: UIViewController = {
    let vc = UIViewController()
    vc.view.backgroundColor = .white
      vc.view.alpha = 0.0
    return vc
  }()
  private let vc2: UIViewController = {
    let vc = UIViewController()
    vc.view.backgroundColor = .white
    return vc
  }()
  private let vc3: UIViewController = {
    let vc = UIViewController()
    vc.view.backgroundColor = .white
    return vc
  }()
  private lazy var pageViewController: UIPageViewController = {
    let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    vc.setViewControllers([self.dataViewControllers[0]], direction: .forward, animated: true)
    vc.delegate = self
    vc.dataSource = self
    vc.view.translatesAutoresizingMaskIntoConstraints = false
    return vc
  }()
  
  var dataViewControllers: [UIViewController] {
    [self.vc1, self.vc2, self.vc3]
  }
  var currentPage: Int = 0 {
    didSet {
      // from segmentedControl -> pageViewController 업데이트
      print(oldValue, self.currentPage)
      let direction: UIPageViewController.NavigationDirection = oldValue <= self.currentPage ? .forward : .reverse
      self.pageViewController.setViewControllers(
        [dataViewControllers[self.currentPage]],
        direction: direction,
        animated: true,
        completion: nil
      )
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.addSubview(self.segmentedControl)
    self.view.addSubview(self.pageViewController.view)
      self.view.addSubview(self.productLabel)
    
    NSLayoutConstraint.activate([
      self.segmentedControl.leftAnchor.constraint(equalTo: self.view.leftAnchor),
      self.segmentedControl.rightAnchor.constraint(equalTo: self.view.rightAnchor),
      self.segmentedControl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 230),
      self.segmentedControl.heightAnchor.constraint(equalToConstant: 50),
    ])
    NSLayoutConstraint.activate([
      self.pageViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 4),
      self.pageViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -4),
      self.pageViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -550),
      self.pageViewController.view.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor, constant: 0),
    ])
    
      NSLayoutConstraint.activate([
        self.productLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor),
        self.productLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor),
        self.productLabel.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor, constant: 40),
      ])
      
    self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
    self.segmentedControl.setTitleTextAttributes(
      [
        NSAttributedString.Key.foregroundColor: UIColor.black,
        .font: UIFont.systemFont(ofSize: 13, weight: .semibold)
      ],
      for: .selected
    )
    self.segmentedControl.addTarget(self, action: #selector(changeValue(control:)), for: .valueChanged)
    self.segmentedControl.selectedSegmentIndex = 0
    self.changeValue(control: self.segmentedControl)
  }
  
  @objc private func changeValue(control: UISegmentedControl) {
    // 코드로 값을 변경하면 해당 메소드 호출 x
    self.currentPage = control.selectedSegmentIndex
  }
}

extension ViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerBefore viewController: UIViewController
  ) -> UIViewController? {
    guard
      let index = self.dataViewControllers.firstIndex(of: viewController),
      index - 1 >= 0
    else { return nil }
    return self.dataViewControllers[index - 1]
  }
  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerAfter viewController: UIViewController
  ) -> UIViewController? {
    guard
      let index = self.dataViewControllers.firstIndex(of: viewController),
      index + 1 < self.dataViewControllers.count
    else { return nil }
    return self.dataViewControllers[index + 1]
  }
  func pageViewController(
    _ pageViewController: UIPageViewController,
    didFinishAnimating finished: Bool,
    previousViewControllers: [UIViewController],
    transitionCompleted completed: Bool
  ) {
    guard
      let viewController = pageViewController.viewControllers?[0],
      let index = self.dataViewControllers.firstIndex(of: viewController)
    else { return }
    self.currentPage = index
    self.segmentedControl.selectedSegmentIndex = index
  }
}
