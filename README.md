#省市区选择  
---  
###tableView展开式中国所有省市,省市区cell,都支持自定义  
###效果图  
![Smaller icon](https://github.com/zhouxubin/ProvinceDemo/blob/master/provinceDemo.gif)  
---    
`只要创建这个tableView就好了,并且设置代理`    
    
    - (void)viewDidLoad {
    	[super viewDidLoad];
    	// Do any additional setup after loading the view, typically from a nib.
    	XBProvinceTableView *tableView = [[XBProvinceTableView alloc] init];
    	tableView.frame = self.view.bounds;
    	tableView.myDelegate = self;
    	[self.view addSubview:tableView];  
    }  

`实现代理方法`   
   
    #pragma mark - XBProvinceTableViewDelegate   
    - (void)provinceTableView:(XBProvinceTableView *)tableView didSelectedAreaCell:(NSIndexPath *)indexPath areaName:(NSString *)areaName {
    	NSLog(@"%@", areaName);
    	[MBProgressHUD showSuccess:areaName];
    }    
`自定义设置`  
    
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
    
        XBProvinceObj *provinceObj = _provinceArray[indexPath.section];
        NSObject *obj = provinceObj.cities[indexPath.row];
        if ([obj isKindOfClass:[XBCityObj class]]) {
        #warning 这里是市的设置,可以在这里自行添加控件
            XBCityObj *cityObj = (XBCityObj *)obj;
            cell.textLabel.text = cityObj.name;
            cell.detailTextLabel.text = nil;
        }else {
        #warning 这里是区的设置,可以在这里自行添加控件
            cell.textLabel.text = nil;
            cell.detailTextLabel.text = (NSString *)obj;
        }
    
        return cell;
    }  
---  
##本控件依赖MJExtension来字典转模型的,这里楼主是为了简单所以就导入了这个框架,攻城狮们如果自己转的话就不用导入这个框架了
