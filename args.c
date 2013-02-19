#include <stdlib.h>
#include <stdio.h>
#include <getopt.h>

void arguments(int argc, char **argv)
{
	int c;

	while (1)
	{
		static struct option long_options[] =
		{
			/* These options don't set a flag.
			  We distinguish them by their indices. */
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
			case 0:
				/* If this option set a flag, do nothing else now. */
				if (long_options[option_index].flag != 0)
					break;
				printf ("option %s", long_options[option_index].name);
				if (optarg)
					printf (" with arg %s", optarg);
				printf ("\n");
				break;

			case 'h':
				puts ("HELP\n");
				break;

			case 'v':
				puts ("VERSION\n");
				break;
			case '?':
				/* getopt_long already printed an error message. */
				break;

			default:
				abort ();
		}
	 }

}
