---
categories:
- 往昔
date: "2025-07-10T00:09:36+08:00"
draft: false
title: C语言实现简易Shell
---

实现一个Shell，需要的功能有：
- 循环读取用户输入
- 输出提示符
- 创建子进程执行命令
- 等待回收子进程

shell中的大多数命令都是通过创建子进程来执行的，可以使用`fork()`创建子进程，然后替换主进程执行命令。
创建
常用函数原型
```c
pid_t fork(void); // pid_t是int类型
pid_t get_pid(); // 获取当前进程pid
pid_ getppid(); // 获取当前进程的父进程值
```


`fork()`用于创建创建一个进程，所阐明的进程复制父进程的代码段/数据段/BSS段/等所有用户空间信息，在内和中操作系统重新为其申请了一个PCB，并使用父进程的PCB初始化。

实现fork()子进程替换为命令子进程, 最佳的进程替换的接口是`exevp()`

在创建子进程前，我们需要解析传递给shell的参数

使用`strtok()`对command以空格进行分割，所以显而易见地，得到的结果数组中，第0位是命令名称，后面全部都是选项。

使用`waitpid()`等待子进程，`fork()`获取的子进程id可以用于制定回收子进程。

```c
#include <pwd.h>
#include <sys/wait.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>

#define MAX_COMMAND_SIZE 256

int main()
{
	char *command_argv[MAX_COMMAND_SIZE];
	char command[MAX_COMMAND_SIZE];
	memset(command, '\n', MAX_COMMAND_SIZE);
	const char* user_name = getlogin();
	while(1)
	{
		printf("[%s@EazyShell]$ ", user_name);
		fgets(command, MAX_COMMAND_SIZE, stdin);
		   command[strcspn(command, "\n")] = '\0'; // 去掉末尾的换行符
		// 分割命令行，一个空格为一项子命令或参数
		command_argv[0] = strtok(command," ");
		int index = 1;
		while(command_argv[index++] = strtok(NULL, " "));

		// 创建子进程，并进程替换
		pid_t id = fork();
		if(id == 0)
		{
			// 进程替换
			execvp(command_argv[0], command_argv);
			return  -1; // 失败则退出-1
		}

		// 父进程回收子进程
		int status = 0;
		pid_t ret = waitpid(id, &status, 0);
		if (ret = 0)
		{
			printf("父进程成功回收子进程, exit_code: %d, exit_sig: %d\n", WEXITSTATUS(status), WTERMSIG(status));
		}
	}

	return 0;
}
```

这个程序的健壮性和内存布局还有待优化，但只是一个简易的shell，用于理解它的工作原理，这就够了。
