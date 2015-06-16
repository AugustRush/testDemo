
#define KEY_WINDOW              [[UIApplication sharedApplication] keyWindow]
#define MAIN_QUEUE              dispatch_get_main_queue()
#define SYBLTPeriHandle         [(SYAppDelegate *)[UIApplication sharedApplication].delegate BLTPeriHandle]

#define SHOW_HUD(text)                  [self showHudInWindowOnlyText:text dismissAfterDelay:1.0f]
#define SAVING_FAILED(title, text)      [self showHudInWindowWithTitle:title detail:text dismissAfterDelay:1.0f]

#define BoolString(AQ_bool)     AQ_bool ? @"是" : @"否"
#define IntString(AQ_int)       [NSString stringWithFormat:@"%d", AQ_int]

#define MEASUER_BUTTON_NORMAL_TEXT_COLOR                SYColor(91, 214, 85)
#define MEASUER_BUTTON_SELECTED_TEXT_COLOR              SYColor(230, 50, 41)

#define kUserA                      @"用户A"
#define kUserB                      @"用户B"
#define kMeasureModeNormal          @"普通模式"
#define kMeasureModeAngiocarpy      @"心血管模式"

// 指令结束标识符
#define AQ_EOF                              @"\0"