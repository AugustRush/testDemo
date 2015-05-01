//
//  ARMessageUIConfigs.h
//  Mindssage
//
//  Created by August on 14/10/31.
//
//

#ifndef Mindssage_ARMessageUIConfigs_h
#define Mindssage_ARMessageUIConfigs_h

#define ARRGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0]

#define ARMessageTimeColor      ARRGB(187,187,187)
#define ARMessageAvatarSize         CGSizeMake(36,36)
#define ARMessageInComingBuddleColor ARRGB(0,204,98)
#define ARMessageOutComingBuddleColor ARRGB(255,255,255) 
#define ARMessageSendingGlowAnimationTimes 3
#define ARShowDateTimeInterval      300
#define ARMessageInputBarMaxLines   8
#define ARMessageTextFont   [UIFont fontWithName:@"HelveticaNeue" size:16]
#define ARMessageTimeFont   [UIFont fontWithName:@"HelveticaNeue" size:12]
#define ARMessageInComingTextColor ARRGB(255,255,255)
#define ARMessageOutComingTextColor ARRGB(51,51,51)
#define ARMessageCellAvatarKey @"_ar_message_avatar"
#define ARMessageCellOppositeImageKey @"_ar_message_info_image"
#define ARMessageTimeTopInset   28
#define ARMessageTimeBottomInset 18

#define kScreenBounds               [[UIScreen mainScreen] bounds]
#define kScreenWidth                kScreenBounds.size.width

#endif
