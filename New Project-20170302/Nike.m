#import "Nike.h"

@implementation Nikunj

 static int gx=0;

-(void) setGlobe
{
  extern int gGlobe;
  ++gGlobe;
  ++gx;

}
-(void) print
{
  NSLog(@"here it's %i",gx);

}


@end