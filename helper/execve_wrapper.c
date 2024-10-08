#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

/**
 * Wrapper for a call to execve where argv contents is read from a set of files.
 *
 * For instance:
 *     execve_wrapper foo 3 /bin/my/exec
 * is equivalent to 
 *     /bin/my/exec `cat foo0.txt` `cat foo1.txt` `cat foo2.txt`
 * if there are no spaces in files foo*.
 */

/**
 * Read the file supplied as argument and returns an allocated buffer
 * with the file contents.
 */
char * getBufferFromFile(char * filename) {
    FILE *fp = fopen (filename , "rb" );
    long lSize = 0;
    char *buffer = NULL;
    
    if(!fp) perror(filename),exit(1);
    
    fseek(fp, 0L, SEEK_END);
    lSize = ftell(fp);
    rewind(fp);
    
    /* allocate memory for entire content */
    buffer = calloc( 1, lSize+1 );
    if(!buffer) fclose(fp),fputs("memory alloc fails",stderr),exit(1);

    if (lSize==0) {
        /* for empty buffer just write 0*/
        buffer[0]=0;
    } else {
        /* copy the file into the buffer */
        if( 1!=fread( buffer , lSize, 1 , fp) )
            fclose(fp),free(buffer),fputs("entire read fails",stderr),exit(1);
    }
    fclose(fp);
    return buffer;
}

int main(int argc, char* argv[]) {
    if (argc<4) {
        fprintf(stderr,"Should provide at least 3 arguments: prefix, num of arg, cmd.\n");
        fprintf(stderr," For instance:\n");
        fprintf(stderr,"     execve_wrapper foo 3 /bin/my/exec\n");
        fprintf(stderr," is equivalent to \n");
        fprintf(stderr,"     /bin/my/exec `cat foo0.txt` `cat foo1.txt` `cat foo2.txt`\n");
        fprintf(stderr," if there are no spaces in files foo*.\n");        
        exit(1);
    }
    char * prefix=argv[1];
    int num=atoi(argv[2]);
    char * values [num+2+argc-3];
    char buf[100];
    for (int i=0;i<argc-3;++i) {
        values[i]=argv[3+i];
    }
    for (int i=0;i<num;++i) {
        sprintf(buf,"%s%d.txt",prefix,i);
        values[i+argc-3]=getBufferFromFile(buf);
    }
    values[num+argc-3]=NULL;
    char *envp[]={NULL};
    if (execve(values[0], values, envp) == -1) {
        int i=0;
        while (values[i]) {
            fprintf(stderr,"(%d)%s ",i,values[i++]);
        }
        perror("Could not execve");
    }
    return 1;
}
