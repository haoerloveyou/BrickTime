#import <UIKit/UIkit.h>
 #include <sys/time.h>
void (*old_settimeofday)(struct timeval*, struct timezone*);
void (*old_TMSetSourceTime)();
%hook PSUIDateTimeController
- (void)datePickerChanged:(UIDatePicker*)arg1{
	NSDate* setDate=arg1.date;
	if(!([setDate  timeIntervalSince1970]>0)){
  	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Gottcha!" message:@"Don't Try This" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	}
	else{
		%orig;
	}
}
%end
void new_settimeofday(struct timeval* tv, struct timezone* tz){
NSDate* setDate=[NSDate dateWithTimeIntervalSince1970:tv->tv_sec];
if(!([setDate  timeIntervalSince1970]>0)){

}
else{
	old_settimeofday(tv,tz);
}
}

%ctor{
	NSString* Identifer=[[NSBundle mainBundle] bundleIdentifier];
	if([Identifer hasPrefix:@"com.apple"]&&Identifer!=nil){
		NSLog(@"Apple Binary? Whitelist");
	}
	else{
	MSHookFunction((void*)settimeofday,(void*)new_settimeofday, (void**)&old_settimeofday);
	//_TMSetSourceTime Exists In CoreTime.framework on iOS void TMSetSourceTime(CFStringRef, CFAbsoluteTime, CFTimeInterval)";
	//Anyone Wanna Fix That?
	}

}

