//
//  main.m
//  CtestDemo
//
//  Created by August on 15/6/28.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reverse.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int i,j,k,m,s=0;
        for(i=0;i<=100;i++)
            for(j=0;j<=50;j++)
                for(k=0;k<=20;k++)
                    for(m=0;m<=10;m++)
                        if((i+2*j+5*k+10*m)==100)
                            s++;
        printf("总数：%d\n",s);
        
        const int N = 100;
        int dimes[] = { 1, 2, 5, 10 };
        int arr[N + 1] = { 1 };
        for (int i = 0; i < sizeof(dimes) / sizeof(int); ++i)
        {
            for (int j = dimes[i]; j <= N; ++j)
            {
//                arr[j] += arr[j - dimes[i]];
                arr[j] = arr[j] + arr[j - dimes[i]];
            }
        }
        
        
        char * c[] = {"a","b","c","d","1","2","3","4"};
        
        for (int i = 4; i< 8; i++) {
            char *t = c[i];
            c[i] = c[i - 3];
            c[i-3] = t;
        }
        
        
        
        printf("sort dimes is %d",BubbleSort(dimes, 4));
        
    }
    return 0;
}
