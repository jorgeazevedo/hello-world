#include <stdlib.h>
#include <stdio.h>
#include <getopt.h>

void print_help(void)
{
        printf("\
Usage: hello-world [OPTION]...\n\
Print a friendly, customizable greeting.\n\
  -h, --help          display this help and exit\n\
  -v, --version       display version information and exit\n\
\n\
Report bugs to: <https://github.com/jorgeazevedo/hello-worldo/issues>\n\
hello-world home page: <https://github.com/jorgeazevedo/hello-world>\n");
}

void print_version(void)
{
	printf("\
hello-world 1.0\n\
Copyright (C) 2013 Jorge Azevedo\n\
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>\n\
This is free software: you are free to change and redistribute it.\n\
There is NO WARRANTY, to the extent permitted by law.\n");
}

void arguments(int argc, char **argv)
{
	int c;

	while (1)
	{
		static struct option long_options[] =
		{
			{"help",     no_argument,       NULL, 'h'},
			{"version",  no_argument,       NULL, 'v'},
			{NULL, 0, NULL, 0}
		};

		/* getopt_long stores the option index here. */
		int option_index = 0;

		c = getopt_long (argc, argv, "hv",
		long_options, &option_index);

		/* Detect the end of the options. */
		if (c == -1)
			break;

		switch (c)
		{
			case 'h':
				print_help();
				exit (EXIT_SUCCESS);
				break;

			case 'v':
				print_version();
				exit (EXIT_SUCCESS);
				break;
			case '?':
				/* getopt_long already printed an error message. */
				break;

			default:
				abort ();
		}
	 }

}

