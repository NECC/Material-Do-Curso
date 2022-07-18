# SO

## Padrões - GUIAO 02

### 1. Filhos sequenciais
```c
int pid, status;
for (int i = 0; i < nfilhos; i++) {
    if ((pid = fork()) == 0) {
        //do anything
        _exit(0);
    } else {
        pid_t terminated = wait(&status);
	    // do anything
    }
}
```

### 2. Filhos concorrentes
```c
int pid, status;
for (int i = 0; i < nfilhos; i++) {
	if ((pid = fork()) == 0) {
	    //do anything
	    _exit(0);
	}
}

for (int i = 0; i < nfilhos; i++) {
	pid_t terminado = wait(&status);
}
```

### 3. Filhos em profundidade
```c
for (int i = 0; i < nfilhos; i++) {
	if ((pid = fork()) == 0) {
	    //do anything
	} else {
		pid_t terminado = wait(&status);
		_exit(0);
	}
}
```

## Padrões - GUIAO 03
Exec's podem ser classificados através das suas letras.
- exec**v** recebe um array de `char*` que termina em NULL
- exec**l** recebe uma lista terminada com NULL utilizando o mecanismo varargs
- execv**p**, execl**p** recebe nome de um programa e procura-o no `Path`
- execv**e**, execl**e** recebe um array de `char*` que termina em NULL com valores para variáveis de ambiente na forma "VARIABLE=value"
