//
//  PieDemoChartViewController.m
//  GGCharts
//
//  Created by _ | Durex on 17/9/22.
//  Copyright © 2017年 I really is a farmer. All rights reserved.
//

#import "PieDemoChartViewController.h"
#import "PieChart.h"
#import "NSAttributedString+GGChart.h"

@interface PieDemoChartViewController ()

@property (nonatomic, strong) PieChart * pieChart;

@property (nonatomic, strong) PieData * pieData;

@end

@implementation PieDemoChartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"扇形图";
    
    // 线的颜色 [绿, 蓝, 黄]
    NSArray * pieColors = @[C_HEX(0x0ACC74), C_HEX(0x089DFF), C_HEX(0xFDBC43)];
    // 人数
    NSArray * sources = @[@58, @8, @13];
    NSArray * outTitle = @[@"保密", @"男", @"女"];
    
    PieData * pie = [[PieData alloc] init];
    pie.radiusRange = GGRadiusRangeMake(GG_SIZE_CONVERT(36), GG_SIZE_CONVERT(36+20));
    pie.showOutLableType = OutSideShow;

    pie.roseType = RoseNormal;
    pie.dataAry = sources;
    // 文字偏移比例
    pie.outSideLable.stringRatio = GGRatioCenterLeft;
    // 文字偏移
    pie.outSideLable.stringOffSet = CGSizeMake(-3, -2);
    // 线长度
    pie.outSideLable.lineLength = GG_SIZE_CONVERT(20);
    // 拐弯线长度
    pie.outSideLable.inflectionLength = GG_SIZE_CONVERT(100);
    // 拐点线终点圆形半径
    pie.outSideLable.linePointRadius = 0;
    //pie.innerLable.stringOffSet = CGSizeMake(-.5, 0);
    // 是否显示扇形图文字
    pie.showInnerString = NO;
    
    
    _pieData = pie;
    
    pie.pieColorsForIndex = ^UIColor *(NSInteger index, CGFloat ratio) {
        return pieColors[index];
    };

    pie.outSideLable.lineColorsBlock = ^UIColor *(NSInteger index, CGFloat ratio) {
        return pieColors[index];
    };
    // 扇形图外边文字
    [self.pieData.outSideLable setAttributeStringBlock:^NSAttributedString *(NSInteger index, CGFloat value, CGFloat ratio) {

        NSInteger total = 0;
        for (NSNumber *num in sources) {
            total += num.integerValue;
        }
        NSNumber * source = sources[index];

        NSString * title = outTitle[index];
        NSString * subTitle = [NSString stringWithFormat:@"占比%.1f%@", source.floatValue / total * 100, @"%"];


        NSString * string = [NSString stringWithFormat:@"● %@  %@\n", title, subTitle];
        NSMutableAttributedString * attrbuteString = [[NSMutableAttributedString alloc] initWithString:string];
        [attrbuteString setText:@"●" color:pieColors[index] font:[UIFont systemFontOfSize:GG_SIZE_CONVERT(8)]];
        [attrbuteString setText:title color:C_HEX(0x666666) font:[UIFont systemFontOfSize:GG_SIZE_CONVERT(10)]];
        [attrbuteString setText:subTitle color:C_HEX(0x666666) font:[UIFont systemFontOfSize:GG_SIZE_CONVERT(10)]];

        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paraStyle.lineSpacing = 5;
        [attrbuteString addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, string.length)];

        return attrbuteString;
    }];

    
    PieDataSet * pieDataSet = [[PieDataSet alloc] init];
    pieDataSet.pieAry = @[self.pieData];
    pieDataSet.showCenterLable = NO;
    
    _pieChart = [[PieChart alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 500)];
    _pieChart.pieDataSet = pieDataSet;
    [_pieChart drawPieChart];
    [_pieChart startAnimationsWithType:RotationAnimation duration:.5f];
    
    [self.view addSubview:_pieChart];
    
    //
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setFrame:CGRectMake(10, 450, 100, 50)];
    [btn setTitle:@"显示外线" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(analogDataFirst) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setFrame:CGRectMake(120, 450, 130, 50)];
    [btn setTitle:@"点击显示外线" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(analogDataSecond) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)analogDataFirst
{
    _pieData.showOutLableType = OutSideShow;
    
    [_pieChart drawPieChart];
    [_pieChart startAnimationsWithType:EjectAnimation duration:.5f];
}

- (void)analogDataSecond
{
    _pieData.showOutLableType = OutSideSelect;
    
    [_pieChart drawPieChart];
    [_pieChart startAnimationsWithType:RotationAnimation duration:.5f];
}

@end
