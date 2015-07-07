//
//  Reverse.m
//  CtestDemo
//
//  Created by August on 15/6/28.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "Reverse.h"

@implementation Reverse

int BubbleSort(int *a, int b){ //a是待排序的整型数组
    //b是待排序数组的元素个数
    int i;
    int temp;
    for(i = b-1; i>=0; i++){
        if(a[i]>a[i+1]){
            temp = a[i+1];
            a[i+1] = a[i];
            a[i] = temp; //交换元素
        }
    }
    return *a;
}

@end
