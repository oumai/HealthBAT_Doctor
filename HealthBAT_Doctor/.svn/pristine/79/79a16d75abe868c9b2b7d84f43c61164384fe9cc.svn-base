//
//  BATContractConfirmViewController.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/20.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATContractConfirmViewController.h"
#import "BATContractContentTableViewCell.h"
#import "BATDoctorStudioMessageModel.h"

@interface BATContractConfirmViewController () <UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>

@property (nonatomic,strong) BATDoctorStudioMessageData *doctorStudioMessageData;

@end

@implementation BATContractConfirmViewController

- (void)dealloc
{
    DDLogDebug(@"%@", self);
}

- (void)loadView
{
    [super loadView];
    
    [self pageLayout];
    
    self.title = @"合同确认";
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.contractConfirmView.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.contractConfirmView.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.contractConfirmView.tableView registerClass:[BATContractContentTableViewCell class] forCellReuseIdentifier:@"BATContractContentTableViewCell"];
    
    if (self.state == 1 || self.state == 2) {
        //0待确认，1已确认，2取消
        //已确认，取消，隐藏footerview
        self.contractConfirmView.tableView.tableFooterView = nil;
    }
    
    
    [self requestGetContract];
    
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

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BATContractContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BATContractContentTableViewCell" forIndexPath:indexPath];
    
    if (self.doctorStudioMessageData) {
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self.doctorStudioMessageData.CompactContent];
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
        style.firstLineHeadIndent = 30;
        [string addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, string.length)];
        
        cell.contentLabel.attributedText = string;
        cell.timeLabel.text = self.doctorStudioMessageData.CreatedTime;
    }
    

    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    
    DDLogDebug(@"height %.f",height);
    
    self.contractConfirmView.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);

    
//    CGSize fittingSize = [self.contractConfirmView.webView sizeThatFits:CGSizeZero];
}

#pragma mark - observie
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGSize fittingSize = [self.contractConfirmView.webView sizeThatFits:CGSizeZero];
//        CGSize fittingSize = [self.contractConfirmView.webView.scrollView contentSize];
        DDLogWarn(@"size %@",NSStringFromCGSize(fittingSize));
        
        self.contractConfirmView.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, fittingSize.height);
        
        [self.contractConfirmView.tableView beginUpdates];
        [self.contractConfirmView.tableView setTableHeaderView:self.contractConfirmView.webView];
        [self.contractConfirmView.tableView endUpdates];
    }
}

#pragma mark - Net

#pragma mark - 获取合同详情（确认合同）
- (void)requestGetContract
{
    
    [self showProgress];
    
    [HTTPTool requestWithURLString:@"/api/Doctor/GetContractByConfirm" parameters:@{@"messageId":self.messageID} type:kGET success:^(id responseObject) {
        
        [self dismissProgress];
        
        self.doctorStudioMessageData = [BATDoctorStudioMessageData mj_objectWithKeyValues:[responseObject objectForKey:@"Data"]];
        
//        [self.contractConfirmView.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"confirmContract" ofType:@"html"]]]];
        
        [self.contractConfirmView.webView loadHTMLString:self.doctorStudioMessageData.CompactContent baseURL:nil];
        
//        [self.contractConfirmView.tableView reloadData];
        
    } failure:^(NSError *error) {
        [self showErrorWithText:error.localizedDescription];
    }];
}

#pragma mark - 确认取消
- (void)requestConfirmContract:(NSInteger)state
{
    [self showProgress];
    
    [HTTPTool requestWithURLString:@"/api/Doctor/ConfirmContract" parameters:@{@"messageId":self.messageID,@"state":@(state)} type:kGET success:^(id responseObject) {
        
        [self dismissProgress];
        
        self.contractConfirmView.tableView.tableFooterView = nil;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BATUpdateMessageStateNotification" object:@{@"messageId":self.messageID,@"state":@(state)}];
        
    } failure:^(NSError *error) {
        [self showErrorWithText:error.localizedDescription];
    }];
}

#pragma mark - pageLayout
- (void)pageLayout
{
    [self.view addSubview:self.contractConfirmView];
    
    WEAK_SELF(self);
    [self.contractConfirmView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - get & set
- (BATContractConfirmView *)contractConfirmView
{
    if (_contractConfirmView == nil) {
        _contractConfirmView = [[BATContractConfirmView alloc] init];
        _contractConfirmView.tableView.delegate = self;
        _contractConfirmView.tableView.dataSource = self;
        _contractConfirmView.webView.delegate = self;
        
        WEAK_SELF(self);
        _contractConfirmView.footerView.confirmContractBlock = ^(){
            STRONG_SELF(self);
            [self requestConfirmContract:1];
        };
        
        _contractConfirmView.footerView.cancelContractBlock = ^(){
            STRONG_SELF(self);
            [self requestConfirmContract:2];
        };
    }
    return _contractConfirmView;
}

@end
