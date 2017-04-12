//
//  CustomTableViewController.swift
//  reuseTest
//
//  Created by wanwu on 2017/4/10.
//  Copyright © 2017年 wanwu. All rights reserved.
//

import UIKit

class CustomTableViewController: UITableViewController {
    
    private var kRefreshHeight: CGFloat = 200.0
    
    var p: PullToRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        p = PullToRefreshControl(scrollView: tableView).addDefaultHeader().addDefaultFooter()
        
        p.header?.addAction(with: .refreshing, action: { [unowned self] _ in
            //模拟数据请求
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5, execute: {
                self.p.header?.endRefresh()
            })
        }).addAction(with: .end, action: { 
            print("那啥 结束了都")
        })
        
        p.footer?.addAction(with: .refreshing, action: { [unowned self] _ in
            //模拟数据请求
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: {
                self.p.footer?.endRefresh()
                self.tableView.reloadData()
            })
        }).addAction(with: .end, action: { 
            print("加载完了")
        })
    }
    @IBAction func ac_down(_ sender: Any) {
        p.header?.beginRefresh()
    }
    
    @IBAction func ac_close(_ sender: Any) {
        p.footer?.autoLoadWhenIsBottom = !(p.footer?.autoLoadWhenIsBottom ?? false)
    }

    @IBAction func ac_up(_ sender: Any) {
        p.footer?.beginRefresh()
    }
    var counter = 20
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        counter += 5
        return counter
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "第 \(indexPath.row) 行"
        return cell
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        refreshView.scrollViewDidScroll(scrollView)
    }
    
    

}