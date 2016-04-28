// Include a_samp
//#include a_samp

#include float
main() {
    new tX, tY, tZ;
    tX = tY = tZ = 1;
    
    new t[3];
    t[0] = t[1] = t[2] = 1;
}

#endinput

// Include y_utils
#include YSI\y_utils

// Functions
bool:boolFunc1(t) {
    if(t == 1) {
        return true;
    }
    return false;
}
bool:boolFunc2(t) {
    return (t == 1);
}

TestFunction(&t) {
    t = 1;
}

// Main Function
main() {
    new tmp;
    
    // Compare if-else to switch
    RUN_TIMING("if-elseif-else") {
        if(tmp == 1) {}
        else if(tmp == 2  ) {}
        else if(tmp == 3  ) {}
        else if(tmp == 4  ) {}
        else if(tmp == 5  ) {}
        else if(tmp == 6  ) {}
        else if(tmp == 7  ) {}
        else if(tmp == 8  ) {}
        else if(tmp == 9  ) {}
        else if(tmp == 10 ) {}
        else {}
    }
    RUN_TIMING("switch") {
        switch(tmp) {
            case 1: {}
            case 2  : {}
            case 3  : {}
            case 4  : {}
            case 5  : {}
            case 6  : {}
            case 7  : {}
            case 8  : {}
            case 9  : {}
            case 10 : {}
            default: {}
        }
    }
    
    // Compare 'new' chain to bunch of 'new's
    RUN_TIMING("new chain") {
        new tmp1, tmp2, tmp3, tmp4, tmp5;
        #pragma unused tmp1, tmp2, tmp3, tmp4, tmp5
    }
    RUN_TIMING("new each") {
        new tmp1;
        new tmp2;
        new tmp3;
        new tmp4;
        new tmp5;
        #pragma unused tmp1, tmp2, tmp3, tmp4, tmp5
    }
    
    // Compare setting multiple variables in a single chain to setting each one by one
    new tmp1, tmp2, tmp3, tmp4, tmp5;
    RUN_TIMING("set chain") {
        tmp1 = tmp2 = tmp3 = tmp4 = tmp5 = 1;
    }
    RUN_TIMING("set each") {
        tmp1 = 1;
        tmp2 = 1;
        tmp3 = 1;
        tmp4 = 1;
        tmp5 = 1;
    }
    
    // Compare an if chain to a bunch of if's
    RUN_TIMING("if chain") {
        if(tmp1 == 1 && tmp2 == 1 && tmp3 == 1 && tmp4 == 1 && tmp5 == 1) {}
    }
    RUN_TIMING("if lot") {
        if(tmp1 == 1)
            if(tmp2 == 1)
                if(tmp3 == 1)
                    if(tmp4 == 1)
                        if(tmp5 == 1) 
                            {}
    }
    
    // Compare array initializing to setting each array element in a loop
    RUN_TIMING("array initialize") {
        new arr[5] = {0, 1, 2, ...};
        #pragma unused arr
    }
    RUN_TIMING("array set each") { // SUPER FUCKING SLOW
        new arr[5];
        for(new i; i < 5; i++)
            arr[i] = i;
    }
    
    // Compare function speed to just setting a variable
    RUN_TIMING("set to") {
        tmp = 1;
    }
    RUN_TIMING("function set to") {
        TestFunction(tmp);
    }
    
    // Compare boolean function results from 'if' to just pure logic return
    RUN_TIMING("func if") {
        boolFunc1(tmp);
    }
    RUN_TIMING("func no if") {
        boolFunc2(tmp);
    }
    
    // Compare floatadd to an operator call
    new Float:ftmp;
    RUN_TIMING("floatadd") {
        ftmp = floatadd(ftmp, 20.0);
    }
    RUN_TIMING("float add") {
        ftmp += 20.0;
    }
    
    // Compare adding '1' methods
    RUN_TIMING("++") {
        tmp++;
    }
    RUN_TIMING("+=") {
        tmp += 1;
    }
    RUN_TIMING("set+") {
        tmp = tmp + 1;
    }
    
    // Compare multiple variables to array.
    RUN_TIMING("access new multi") {
        new tX, tY, tZ;
        tX = tY = tZ = 1;
        #pragma unused tX, tY, tZ
    }
    RUN_TIMING("access new array") {
        new t[3];
        t[0] = t[1] = t[2] = 1;
    }
    
    // Compare using 'if's to using ternary operators
    RUN_TIMING("if set") {
        if(tmp == 2)
            tmp = 7;
        else
            tmp = 6;
    }
    RUN_TIMING("ternary set") {
        tmp = (tmp == 2 ? 7 : 6);
    }
}
