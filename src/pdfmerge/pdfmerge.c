#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(const int argc, const char *argv[])
{
	if (argc < 4)
	{
		printf("usage: pdfmerge output.pdf input1.pdf input2.pdf ...\n");
		exit(1);
	}

	char out_file_flag[] = "-sOutputFile=";
	size_t of_flag_len = strlen(out_file_flag), of_len = strlen(argv[1]);
	char *out_file_arg = (char*) malloc(of_flag_len + of_len + 1);
	memcpy(out_file_arg, out_file_flag, of_flag_len);
	memcpy(out_file_arg+of_flag_len, argv[1], of_len+1);

	char *cmd_args[] = {
		"gs", 
		"-dBATCH", 
		"-dNOPAUSE", 
		"-q", 
		"-sDEVICE=pdfwrite", 
		out_file_arg,
		NULL
	};

	// Get size of argv[2:]
	size_t arg_size = 0;
	for (int i = 2; i < argc; i++)
	{
		arg_size += sizeof(argv[i]);
	}
	arg_size += sizeof(cmd_args);

	// Copy argv[2:] to all_args
	char **all_args = malloc(arg_size);
	memcpy(all_args, cmd_args, sizeof(cmd_args));

	for (int i = 2; i < argc; i++)
	{
		all_args[i+4] = strdup(argv[i]);
	}
	all_args[argc + 4] = NULL;


	// Make call 
	pid_t c_pid, pid;
	int status;

	c_pid = fork();

	if (c_pid == 0)
	{
		// Child 

		// Print call to user
		int i = 0;
		while (all_args[i] != NULL)
		{
			printf("%s ", all_args[i]);
			i++;
		}
		printf("\n");

		execvp(all_args[0], all_args);

		// Only get here if exec failed
		perror("execve failed");
	}
	else if (c_pid > 0)
	{
		// Parent 

		if( (pid = wait(&status)) < 0)
		{
			perror("wait");
			_exit(1);
		}

	}
	else
	{
		perror("fork failed");
		_exit(1);
	}

	return 0; 
}
