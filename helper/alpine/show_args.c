#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

int main(int argc, char* argv[], char *envp[]) {
    for (int i=0;i<argc;++i) {
        printf("argv[%d]=%s\n",i,argv[i]);
    }
    printf("envp[0]=%s\n",envp[0]);
    for (int i=0;envp[i]!=NULL;++i) {
        printf("envp[%d]=%s\n",i,envp[i]);
    }
    return 0;
}
