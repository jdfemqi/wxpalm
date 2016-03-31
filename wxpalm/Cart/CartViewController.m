//
//  CartViewController.m
//  wxpalm
//
//  Created by qiujian on 16/3/23.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//  购物车

#import "CartViewController.h"
#import "CellShoppingList.h"
#import "FMDB.h"

@interface CartViewController ()
{
    NSMutableArray* recordArray;
}
@property(nonatomic,strong)FMDatabase *db;
@property (weak, nonatomic) IBOutlet UILabel *_labTitle;
@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 数据库操作 begin
    NSString* fileName = [[NSBundle mainBundle]pathForResource:@"student" ofType:@"sqlite"];
    FMDatabase* db = [FMDatabase databaseWithPath:fileName];
    
    // 打开数据库
    if ([db open]) {
        //  创表
        BOOL result=[db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);"];
        if (result) {
            NSLog(@"创表成功");
        }else
        {
            NSLog(@"创表失败");
        }
    }
    
    self.db = db;
    // 数据库操作 end
    
    [self insert];
    [self query];
    
    self.title = @"购物车";
    self._labTitle.text = self.title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//插入数据
-(void)insert
{
    for (int i = 0; i<10; i++) {
        NSString *name = [NSString stringWithFormat:@"jack-%d", arc4random_uniform(100)];
        // executeUpdate : 不确定的参数用?来占位
        [self.db executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?, ?);", name, @(arc4random_uniform(40))];
        //        [self.db executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?, ?);" withArgumentsInArray:@[name, @(arc4random_uniform(40))]];
        
        // executeUpdateWithFormat : 不确定的参数用%@、%d等来占位
        //        [self.db executeUpdateWithFormat:@"INSERT INTO t_student (name, age) VALUES (%@, %d);", name, arc4random_uniform(40)];
    }
}

//删除数据
-(void)delete
{
    //    [self.db executeUpdate:@"DELETE FROM t_student;"];
    [self.db executeUpdate:@"DROP TABLE IF EXISTS t_student;"];
    [self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);"];
}

//查询
- (void)query
{
    //获取数据
    recordArray = [[NSMutableArray alloc]init];
    
    
    // 执行查询语句
    FMResultSet *resultSet = [self.db executeQuery:@"SELECT * FROM t_student"];
    
    // 遍历结果
    while ([resultSet next]){
        int ID = [resultSet intForColumn:@"id"];
        NSString *name = [resultSet stringForColumn:@"name"];
        int age = [resultSet intForColumn:@"age"];
        NSLog(@"%d %@ %d", ID, name, age);
        
        [recordArray addObject: name];
    }
    
    [resultSet close];
    [self.db close];
}

#pragma mark Table Data Source Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* RootViewControllerCell = @"CellShoppingList";
    
    CellShoppingList* cell = [tableView dequeueReusableCellWithIdentifier:RootViewControllerCell];
    
    if (cell == nil) {
        cell = [[CellShoppingList alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RootViewControllerCell];
    }
    
    // Configure the cell
    NSUInteger row = [indexPath row];

    // 2.遍历结果
    NSString* strTitle = recordArray[row];
    
    cell._labMotif.text = strTitle;
    
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
