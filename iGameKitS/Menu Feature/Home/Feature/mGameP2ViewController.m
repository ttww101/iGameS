//
//  mGameP2ViewController.m
//  iHealthS
//
//  Created by Apple on 2019/4/1.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import "mGameP2ViewController.h"
#import "GameDataP2.h"
#import "mGame2ImageTableViewCell.h"
#import "mGame2LableTableViewCell.h"

@interface mGameP2ViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *P2Title;
@property (weak, nonatomic) IBOutlet UITableView *P2tableView;

@property NSMutableArray * ImageData;
@property NSMutableArray * typeData;
@property NSMutableArray * AllData;

@property (weak, nonatomic) NSString *addstr;

@end

NSURL *imageURL;


@implementation mGameP2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _ImageData = [[NSMutableArray alloc] init];
    _typeData = [[NSMutableArray alloc] init];
    _AllData = [[NSMutableArray alloc] init];
    _addstr = @"";
    
    [self initTable];
}

-(void)getJson{
    
    //第一步，创建URL
    NSURL *url = [NSURL URLWithString:@"http://47.75.131.189/9e45e4e371e876e8a47a63fe8db80cee/"];
    NSDictionary *jsonBodyDict = @{@"type":@"detail", @"id":_P2_id};
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //设置请求方式为POST，默认为GET
    [request setHTTPMethod:@"POST"];
    //设置参数
    NSData *jsonBodyData = [NSJSONSerialization dataWithJSONObject:jsonBodyDict options:kNilOptions error:nil];
    [request setHTTPBody:jsonBodyData];
    
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *jsonString = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    
    GameDataP2 *Gdata = [[GameDataP2 alloc] initWithString:jsonString error:nil];
    for(int i = 0 ; i < Gdata.data.count; i += 1){
        P2DATA *data = Gdata.data[i];
        [_P2Title setText:data.title];
        
        for(int y = 0; y < data.image.count; y++){
            [_typeData addObject:@"1"];
            [_AllData addObject:data.image[y]];
        }
        _addstr = @"";
        for(int j = 0; j < data.content.count; j++){
            _addstr  = [NSString stringWithFormat: @"%@ \n %@", _addstr, data.content[j]];
        }
        [_typeData addObject:@"2"];
        [_AllData addObject:_addstr];
    }

    [self.P2tableView reloadData];
}

-(void)initTable{
    self.P2tableView.dataSource = self;
    self.P2tableView.delegate =  self;
    [self.P2tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self getJson];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _AllData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(_typeData[indexPath.row] == @"1"){
        
        NSLog(@"TYPE: %@", kSSLSessionConfig_TLSv1_RC4_fallback
              );
        mGame2ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell"];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        imageURL = [NSURL URLWithString:_AllData[indexPath.row]];
        cell.P2image.tag = indexPath.row;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // Update the UI
                    cell.P2image.image = [UIImage imageWithData:imageData];
            });
        });
        
        return cell;
    } else {
        
        mGame2LableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lableCell"];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [cell.P2lable setText:_AllData[indexPath.row]];
        
        return cell;
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

@end
