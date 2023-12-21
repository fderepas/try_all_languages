#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

/**
 * Read the file supplied as argument and returns an allocated buffer
 * with the file contents.
 */
char * getBufferFromFile(char * filename) {
    FILE *fp;
    long lSize;
    char *buffer;
    
    fp = fopen (filename , "rb" );
    if( !fp ) perror(filename),exit(1);
    
    fseek( fp , 0L , SEEK_END);
    lSize = ftell( fp );
    rewind( fp );
    
    /* allocate memory for entire content */
    buffer = calloc( 1, lSize+1 );
    if( !buffer ) fclose(fp),fputs("memory alloc fails",stderr),exit(1);
    
    /* copy the file into the buffer */
    if( 1!=fread( buffer , lSize, 1 , fp) )
        fclose(fp),free(buffer),fputs("entire read fails",stderr),exit(1);
    fclose(fp);
    return buffer;
}

int main(int argc, char* argv[]) {
    if (argc<3) {
        fprintf(stderr,"Should provide 3 arguments: prefix, num of arg, cmd.\n");
        exit(1);
    }
    char * prefix=argv[1];
    int num=atoi(argv[2]);
    char * cmd=argv[3];
    char * values [num+2];
    char buf[100];
    for (int i=0;i<num;++i) {
        sprintf(buf,"%s%d.txt",prefix,i);
        values[i+1]=getBufferFromFile(buf);
    }
    values[0]=cmd;
    values[num+1]=NULL;
    char *envp[]={NULL};
    if (execve(values[0], values, envp) == -1)
        perror("Could not execve");
    return 1;
}
