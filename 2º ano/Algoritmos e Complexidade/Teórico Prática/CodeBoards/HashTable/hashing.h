#ifndef hashing_h
#define hashing_h


#define EMPTY       "-"
#define DELETED     "+"


struct pair {
    char key[20];
    int value;
};
    
typedef struct {
    int   size;
    int   used;
    struct pair *tbl;
} HT;


// any hash function
int hash(char key[], int size);


// ENSURES array is allocated and initialized with key EMPTY everywhere
void initHT (HT *h, int size);


// REQUIRES key does not occur in table h (no defensive code)
// (alternatives would be to check defensively, OR to use an update semantics whenever key occurs already)
// ENSURES pair (key, value) is inserted in table h
//         uses linear probing and inserts in next EMPTY or DELETED position
//         returns array index where pair is inserted
//         if load becomes higher than 80%, table is reallocated 
//         ("double" size / nearest prime number)
int writeHT (HT *h, char key[], int value);



//  since writeHT does not implement an update semantics, one way to update is to use read to return index and do a "hard update"


// REQUIRES key occurs at most once in table h
// ENSURES returns array position where key is found or -1 otherwise
//         (this allows the function to be used as auxiliary for update / removal)
//         writes value associated with key in *value
//         uses linear probing treating DELETED positions as occupied
int readHT (HT *h, char key[], int* value);



// ASSUMES key occurs at most once in table h
// ENSURES returns array position where key was found or -1 otherwise
//         marks position as DELETED
//         uses linear probing treating DELETED positions as occupied
int deleteHT (HT *h, char key[]);







#endif /* hashing_h */
