

#import <Foundation/Foundation.h>

@interface NSScanner (Confident)
- (int)nextInt;
- (NSString *)nextString;

@end


@implementation NSScanner (Confident)

-(int) nextInt {
   int res;
   [self scanInt:&res];
   return res;
}

-(long long) nextLong {
   long long res;
   [self scanLongLong:&res];
   return res;
}

- (NSString *)nextString {
   NSString * nextLine = nil;
   [self scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\n"] intoString:&nextLine];
   return nextLine;
}


@end


int N;
NSMutableString * result;

NSString * wholeTestCase() {
   NSString * fileInput = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"input" ofType:@""] encoding:NSUTF8StringEncoding error:nil];
   return fileInput;
}


void addCaseResult(int caseNum, NSString * value) {
   [result appendFormat:@"Case #%d: %@\n", caseNum, value];
}

void printResult() {
   NSLog(@"%@",result);
   NSError * error = nil;
   if (![result writeToFile:@"/Users/paultaykalo/Programming/Archive/Output/output" atomically:YES encoding:NSUTF8StringEncoding error:&error]) {
      NSLog(@"Error : %@", error);
   }

}

NSArray * defaultTestCasesArray() {
   NSString * fileInput = wholeTestCase();
   NSScanner * scanner = [NSScanner scannerWithString:fileInput];
   [scanner scanInt:&N];
   NSMutableArray * result = [NSMutableArray array];
   for (int i = 0 ; i < N; i++) {
      NSString * nextLine = nil;
      [scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\n"] intoString:&nextLine];
      [result addObject:nextLine];
   }
   return result;
}


NSScanner * customTestCasesScanner () {
   NSString * fileInput = wholeTestCase();
   NSScanner * scanner = [NSScanner scannerWithString:fileInput];
   [scanner scanInt:&N];
   return scanner;
}



