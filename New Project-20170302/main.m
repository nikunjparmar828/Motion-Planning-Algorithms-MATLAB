#import <Foundation/Foundation.h>
#import "Nike.h"

int gGlobe=1; 
int main (int argc, const char * argv[])
{
   NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init]; 
    enum binary {a=1,b,x};
    enum binary no=1;
   Nikunj *me=[Nikunj new];
   [me setGlobe];
   
   NSLog(@"you'r stuff is change to this %i",gGlobe); 
   NSLog(@"%d",x);
   
   [me print];
   
   [me release];
   [pool drain];
   return 0;
}
