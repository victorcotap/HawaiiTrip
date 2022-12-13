//
//  ViewController.swift
//  
//
//  Created by Victor Levasseur on 12/12/22.
//

import UIKit

class HawaiiViewControllerViewController: UIViewController {

    private var viewModel: HawaiiViewModel

    init(viewModel: HawaiiViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func bindCardState() {
        viewModel.$state.sink { state in
            // config with state / presentation
        }
        viewModel.$locations.sink { locations in
            // populate some kind of list
        }
    }

    @IBAction func someButton() async {
        await viewModel.buttonClicked()
    }
}
