# 50 Questões - Resoluções em C

**Arquivo original:** [questoes.c](/universidade/1ano/2semestre/PI/code/resolucoes/questoes1/questoes.c)
**Links:**  [[Q1.pdf]]

---

### 1. Maior elemento de uma sequência
Lê uma sequência de números terminada em 0 e devolve o maior.

```c
int calc_maior2(){
    int atual, maior;
    printf("lista os numeros (avisas que acabaste usando o número 0)\n");
    scanf("%d", &atual);
    maior = atual;
    while (atual != 0){
        if (atual > maior) maior = atual;
        scanf("%d", &atual);
    }
    return maior;
}
```

## 2. Média de uma sequência
Lê uma sequência terminada em 0 e calcula a média.

```c
int average2 () {
    int numero; 
    int soma = 0; 
    int contador = 0; 

    printf("oh men lista os numeros (termina em 0)");
    scanf("%d", &numero);
    while (numero != 0){
        soma += numero;
        contador++;
        scanf("%d", &numero);
    }
    if (contador == 0) {
        return 0;
    }
    return soma / contador;
}
```

## 3. Segundo maior elemento
Encontra o segundo maior elemento de uma sequência terminada em 0.

```c
int segundo_maior2() {
    int numero;
    int maior = 0; 
    int seg_maior = 0;
    printf("Escribe los números (termina con 0):\n");
    scanf("%d", &numero);
    while (numero != 0) {
        if (numero > maior) {
            seg_maior = maior; 
            maior = numero;   
        }
        else if (numero > seg_maior) {
            seg_maior = numero;
        }
        scanf("%d", &numero);
    }
    return seg_maior;
}
```

## 4. Bits com valor 1 (`bitsUm`)
Calcula o número de bits iguais a 1 na representação binária de `n`.

```c
int bitsUm (unsigned int n){
    int contador = 0;
    while (n > 0){
        if (n % 2 == 1){
            contador++;
        }
        n = n / 2;
    }
    return contador;
}
```

## 5. Zeros no final (`trailingZ`)
Calcula o número de bits a 0 no final da representação binária de `n`.

```c
int trailingZ (unsigned int n){
    if (n == 0) return 32; 
    int contador = 0; 
    while (n % 2 == 0){
        contador++;
        n = n / 2;
    }
    return contador;
}
```

## 6. Número de dígitos (`qDig`)
Calcula o número de dígitos necessários para escrever o número `n` em base decimal.

```c
int qDig (unsigned int n){
    int digitos = 0; 
    if (n == 0) return 1;
    while (n > 0){
        digitos++;
        n = n / 10;
    }
    return digitos;
}
```

## 7. Concatenar strings (`strcat`)
Anexa a string `s2` ao final da string `s1`.

```c
char *strcat (char s1[], char s2[]){
    int i, j;
    for (i = 0; s1[i] != '\0'; i ++);
    for (j = 0; s2[j] != '\0'; j ++)
        s1[i++] = s2[j]; 
    s1[i] = '\0';
    return s1;
}
```

## 8. Copiar strings (`strcpy`)
Copia a string `source` para `dest`.

```c
char *strcpy (char *dest, char source[]){
    int i;
    for (i = 0; source[i] != '\0'; i ++){
        dest[i] = source[i];
    }
    dest[i] = '\0';
    return dest;
}
```

## 9. Comparar strings (`strcmp`)
Compara duas strings lexicograficamente.

```c
int strcmp (char s1[], char s2[]){
    int i = 0;
    while (s1[i] == s2[i] && s1[i] != '\0')
        i ++;
    return (s1[i] - s2[i]);
}
```

## 10. Procurar substring (`strstr`)
Procura a primeira ocorrência da string `s2` na string `s1`.

```c
char *strstr (char s1[], char s2[]){
    int i = 0, j = 0;
    for (i = 0; s1[i] != '\0'; i ++){
        j = 0;
        while (s1[i + j] == s2[j] && s2[j] != '\0')
            j ++;
        if (s2[j] == '\0')
            return s1 + i;
    }
    return NULL;
}
```

## 11. Inverter string (`strrev`)
Inverte a string `s` in-place.

```c
void strrev (char s[]){
    int i = 0, inicio = 0, fim;
    while (s[i] != '\0')
        i ++;
    fim = i - 1;
    while (inicio < fim){
        char temp;
        temp = s[inicio];
        s[inicio] = s[fim];
        s[fim] = temp;
        inicio ++;
        fim --;
    }
}
```

## 12. Remover vogais (`strnoV`)
Remove todas as vogais da string `s`. Inclui função auxiliar `eVogal`.

```c
int eVogal (char c){
    if (c >= 'a' && c <= 'z') 
        c = c + 'A' - 'a';
    return (c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U');
}

void strnoV (char s[]){
    int i, j = 0;
    for (i = 0; s[i] != '\0'; i ++)
        if (! eVogal(s[i])) s[j++] = s[i];
    s[j] = '\0';
}
```

## 13. Truncar palavras (`truncW`)
Trunca todas as palavras de `t` para terem no máximo `n` caracteres.

```c
void truncW (char t[], int n){
    int i, j = 0, contador = 0;
    for (i = 0; t[i] != '\0'; i ++){
        if (t[i] == ' '){
            t[j++] = t[i];
            contador = 0;
        } else {
            if (contador < n) {
                t[j++] = t[i]; 
                contador ++;
            }
        }
    }
    t[j] = '\0';
}
```

## 14. Caractere mais frequente (`charMaisFreq`)

_(A implementar...)_
```c
char charMaisFreq (char s[]){

}
```