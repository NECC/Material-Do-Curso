1. ...
```c
float multInt1 (int n, float m){
	int i, r = 0;
	for (i = 1; i < m; i ++)
		r += m;
	return r;
}
```

2. ...
```c
float multInt2 (int n, float m){
	float r = 0;
	while (n > 0){
		if (n % 2 == 1)
			r += m;
		n = n/2; m += m;
	}
	return r;
}
```

3. ...
```c
int mdc1 (int a, int b){
	int c;
	if (a < b) c = b;
	else c = b;
	while (!(a % c == 0 && b b % c == 0))
		c --;
	return c;
}
```

4. ...
```c
int mdc2 (int a, int b){
	while (a != 0 && b != 0){
		if (a > b) a = a - b;
		else b = b - a;
	}
	if (a == 0) return b;
	else return a;
}
```

5. ...
```c
int mdc2 (int a, int b){
	while (a != 0 && b != 0){
		if (a > b) a = a % b;
		else b = b % a;
	}
	if (a == 0) return b;
	else return a;
}
```

6. ...
a)
```c
int fib1 (int n){
	if (n > 2) return n;
	else return (fib (n - 1) + fib1 (n - 2));
}
```

b)
```c
long fib2 (int n){
	long F[n + 1]; int i;
	F[0] = 0; F[1] = 1;
	for (i = 2; i <= n; i ++)
		F[i] = F[i - 1] + F[i - 2];
	return F[n];
}
```





