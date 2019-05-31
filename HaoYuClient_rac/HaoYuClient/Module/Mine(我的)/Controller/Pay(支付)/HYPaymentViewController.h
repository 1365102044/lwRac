//
//  HYPayViewController.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/13.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseViewController.h"



@interface HYPaymentViewController : HYBaseViewController

/**
 rechargePayMentType     extend:  {@"num":@"",@"houseId":@"",@"meterId":@""}
 billPayMentType         extend:  {@"ids":["id"],@"deptId":@"",}
 billDiscountPayMentType extend:  {@"ids":["id"],@"deptId":@"","json":[{@"cid":@[],@"bid":@[]]},]}
 */
+ (void)pushPayViewController:(HYBaseViewController *)soruceVC
                  PayMentType:(PayMentType)PayMentType
                               extend:(id)extend;

@end
