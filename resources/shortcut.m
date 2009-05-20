// shortcut.m
// 
// compile:
// gcc shortcut.m -o shortcut.bundle -g -framework Foundation -framework Carbon -dynamiclib -fobjc-gc -arch i386 -arch x86_64

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <Carbon/Carbon.h>

@interface Shortcut : NSObject
{
    id delegate;
}
@property (assign) id delegate;
- (void) addShortcut;
@end

OSStatus myHotKeyHandler(EventHandlerCallRef nextHandler, EventRef anEvent, void *userData);

@implementation Shortcut
@synthesize delegate;

- (void)addShortcut
{
  EventHotKeyRef myHotKeyRef;
  EventHotKeyID myHotKeyID;
  EventTypeSpec eventType;
  eventType.eventClass=kEventClassKeyboard;
  eventType.eventKind=kEventHotKeyPressed;
  InstallApplicationEventHandler(&myHotKeyHandler,1,&eventType,(void *)delegate,NULL);
  myHotKeyID.signature='mhk1';
  myHotKeyID.id=1;
  RegisterEventHotKey(49, controlKey+optionKey, myHotKeyID, GetApplicationEventTarget(), 0, &myHotKeyRef);
}

@end

OSStatus myHotKeyHandler(EventHandlerCallRef nextHandler, EventRef anEvent, void *userData)
{
  id delegate = (id)userData;
  NSLog(@"YEAY WE DID A GLOBAL HOTKEY");
  if ( delegate && [delegate respondsToSelector:@selector(hotkeyWasPressed)] ) {
      [delegate hotkeyWasPressed];
  }
  return noErr;
}

void Init_shortcut(void) {}