#include <stdlib.h>
#include <stdio.h>
#include <getopt.h>

const char* package_name = "package_name";

void print_help(void)
{
  //TODO: this should not be staticaly defined
  const char* program_name = "hello-world";
  const char* package_bugreport = "bug-report";
  const char* package_url = "package_url";

        printf ("\
Usage: %s [OPTION]...\n", program_name);

  printf("\
Print a friendly, customizable greeting.\n", stdout);
  printf("\
  -h, --help          display this help and exit\n\
  -v, --version       display version information and exit\n", stdout);

  printf("\n");
  printf("\
Report bugs to: %s\n", package_bugreport);
  printf("%s home page: <%s>", package_name, package_url);
}

void print_version(void)
{
//TODO: there must be a better way to handle this
  const char* package_version = "1.0";
  printf("hello (GNU %s) %s\n", package_name, package_version);
  printf("");

  /* It is important to separate the year from the rest of the message,
     as done here, to avoid having to retranslate the message when a new
     year comes around.  */
  printf("\
Copyright (C) %s Jorge Azevedo\n\
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>\n\
This is free software: you are free to change and redistribute it.\n\
There is NO WARRANTY, to the extent permitted by law.\n",
              "2013");
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

