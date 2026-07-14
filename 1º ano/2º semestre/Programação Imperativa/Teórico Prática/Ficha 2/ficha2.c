#include<stdlib.h>
#include<stdio.h>

// Ex 1
float multInt1 (int n, float m){
    float r = 0;
    int i;
    for (i = 0; i < n; i++) r += m;
    return r;

}

// Ex 2
float multInt2 (int n, float m){
    float r = 0;
    
    for (; n > 1; n/=2) {
        if (n % 2 != 0) r += m;
        m*=2;
    }
    
    return r + m;

}

// Ex 3
int mdc1 (int a, int b){
    int div = 1;
    int n = (a > b) ? b : a;
    int i;
    
    for (i = 2; i <= n; i++) {
        if (a % i == 0 && b % i == 0) div = i;
    }

    return div;
}

// Ex 4
int mdc2(int a, int b) {
    while (a != b) {
        if (a > b) a-=b;
        else b-=a;
    }
    return a;
}

// Ex 5
int mdc3(int a, int b) {
    while (a != 0 && b != 0) {
        if (a > b) a%=b;
        else b%=a;
    }
    return a+b;
}

// Ex 6a
int fib1(int n) {
    if (n < 2) return 1;
    else return fib(n-1) + fib(n-2);
}

// Ex 6b
int fib2(int n) {
    int i, a = 1, b = 1;
    for (i = 2; i != n; i++) {
        b += a;
        a = b - a;
    }
    return b;
}