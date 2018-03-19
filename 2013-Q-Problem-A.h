#import <CodeJam-Helper.h>

int main(int argc, char *argv[]) {
    NSAutoreleasePool * pool = [NSAutoreleasePool new];
    result = [[NSMutableString new] autorelease];
    NSScanner * scanner = customTestCasesScanner();
    for (int n = 0; n < N; n++) {

        int field[4][4];
        int hsum[4];
        int vsum[4];
        int d1sum = 0;
        int d2sum = 0;
        for (int l = 0; l < 4; l++) {
            hsum[l] = vsum[l] = 0;
        }
        BOOL hasEmptyFields = NO;
        BOOL XWinner = NO;
        BOOL OWinner = NO;

            for (int i  = 0; i < 4; i++) {
                NSString * s = [scanner nextString];
                for (int j = 0; j < 4; j++) {
                    unichar c = [s characterAtIndex:j];
                    int weight = 0;
                    switch (c) {
                        case '.':
                            hasEmptyFields = YES;
                            break;
                        case 'T':
                            weight = 1;
                            break;
                        case 'O':
                            weight = 10;
                            break;
                        case 'X':
                            weight = 100;
                        default:
                            break;
                    }
                    hsum[i] += weight;
                    vsum[j] += weight;
                    if (i == j) {
                        d1sum+= weight;
                    }
                    if (i == 3 - j) {
                        d2sum+=weight;
                    }

                    if (
                     hsum[i] == 400 || hsum[j] == 301 ||
                     vsum[j] == 400 || vsum[j] == 301 ||
                      d1sum == 400 || d1sum == 301 ||
                      d2sum== 400 || d2sum == 301
                     ) {
                        XWinner = YES;
                    }

                    if (
                     hsum[i] == 40 || hsum[j] == 31 ||
                      vsum[j] == 40 || vsum[j] == 31 ||
                      d1sum == 40 || d1sum == 31 ||
                      d2sum== 40 || d2sum == 31
                     ) {
                        OWinner = YES;
                    }
                }
            }
    [scanner nextString];


for (int m = 0; m < 4; m++) {
NSLog(@"hsum[%d] = %d",m,hsum[m]);
}
for (int m = 0; m < 4; m++) {
NSLog(@"vsum[%d] = %d",m,vsum[m]);
     }
NSLog(@"d1sum = %d", d1sum);
NSLog(@"d2sum = %d", d2sum);
        if (XWinner) {
            addCaseResult(n+1, @"X won");
        } else if (OWinner) {
            addCaseResult(n+1, @"O won");
        } else if (hasEmptyFields) {
            addCaseResult(n+1, @"Game has not completed");
        } else {
            addCaseResult(n+1, @"Draw");
        }
    }
    printResult();
    [pool release];
    return 0;
}
