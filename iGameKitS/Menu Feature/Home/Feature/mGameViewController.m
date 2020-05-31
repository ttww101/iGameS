//
//  mGameViewController.m
//  iHealthS
//
//  Created by Apple on 2019/4/1.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import "mGameViewController.h"
#import "GameDataP1.h"
#import "mGameTableViewCell.h"
#import "mGameP2ViewController.h"

@interface mGameViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UIButton *btnL;
@property (weak, nonatomic) IBOutlet UIButton *btnC;
@property (weak, nonatomic) IBOutlet UIButton *btnR;

@property NSMutableArray * TitleData;
@property NSMutableArray * ImgData;
@property NSMutableArray * ContentData;

@property NSMutableArray * idData;

@end

NSURL *imageURL;
NSString * type_s;
NSString * p1_id;

@implementation mGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    type_s = @"single";
    
    _TitleData = [[NSMutableArray alloc] init];
    _ImgData =[[NSMutableArray alloc] init];
    _ContentData =[[NSMutableArray alloc] init];
    _idData = [[NSMutableArray alloc] init];

    [self.btnL addTarget:self
               action:@selector(LClicked:)
     forControlEvents:UIControlEventTouchUpInside
     ];
    
    [self.btnC addTarget:self
               action:@selector(CClicked:)
     forControlEvents:UIControlEventTouchUpInside
     ];
    
    [self.btnR addTarget:self
               action:@selector(RClicked:)
     forControlEvents:UIControlEventTouchUpInside
     ];
    
    [self initTable];
}

-(void)initTable{
    self.mTableView.dataSource = self;
    self.mTableView.delegate =  self;
    [self.mTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self getTitleJson];
}

-(void)getTitleJson{
    [_TitleData removeAllObjects];
    [_ImgData removeAllObjects];
    [_ContentData removeAllObjects];
    [_idData removeAllObjects];

    //第一步，创建URL
    NSURL *url = [NSURL URLWithString:@"http://47.75.131.189/9e45e4e371e876e8a47a63fe8db80cee/"];
    NSDictionary *jsonBodyDict = @{@"type":type_s};
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //设置请求方式为POST，默认为GET
    [request setHTTPMethod:@"POST"];
    //设置参数
    NSData *jsonBodyData = [NSJSONSerialization dataWithJSONObject:jsonBodyDict options:kNilOptions error:nil];
    [request setHTTPBody:jsonBodyData];
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *jsonString = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    
    GameDataP1 *Gdata = [[GameDataP1 alloc] initWithString:jsonString error:nil];
     for(int i = 0 ; i < Gdata.data.count; i += 1){
         DATA *data = Gdata.data[i];
         
          [_TitleData addObject:data.title];
          [_ImgData addObject:data.image];
          [_ContentData addObject:data.content];
          [_idData addObject:data.id];
     }
    
    [self.mTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _TitleData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    mGameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mGameCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.titleL setText:[_TitleData objectAtIndex:indexPath.row]];
    
    imageURL = [NSURL URLWithString:_ImgData[indexPath.row]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            cell.imgV.image = [UIImage imageWithData:imageData];
        });
    });
    
    [cell.infoL setText:[_ContentData objectAtIndex:indexPath.row]];
    
    cell.item_btn.tag = indexPath.row;
    [cell.item_btn addTarget:self action:@selector(onClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (IBAction)onClicked:(UIButton *)sender{
    p1_id = _idData[(long)sender.tag];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"mG2"]) {
        
        mGameP2ViewController *view2 = segue.destinationViewController;
        view2.P2_id = p1_id;
    }
}

- (void) LClicked:(id)sender {
    [self.btnL setTitleColor:[UIColor colorWithRed:223.0f/255.0f
                                             green:94.0f/255.0f
                                              blue:0.0f/255.0f
                                             alpha:1.0f] forState:UIControlStateNormal];
    [self.btnC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    type_s = @"single";
    [self getTitleJson];
}

- (void) CClicked:(id)sender {
    [self.btnL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnC setTitleColor:[UIColor colorWithRed:223.0f/255.0f
                                             green:94.0f/255.0f
                                              blue:0.0f/255.0f
                                             alpha:1.0f] forState:UIControlStateNormal];
    [self.btnR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    type_s = @"mobile";
    [self getTitleJson];
}

- (void) RClicked:(id)sender {
    [self.btnL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnR setTitleColor:[UIColor colorWithRed:223.0f/255.0f
                                             green:94.0f/255.0f
                                              blue:0.0f/255.0f
                                             alpha:1.0f] forState:UIControlStateNormal];
    
    type_s = @"online";
    [self getTitleJson];
}

@end
