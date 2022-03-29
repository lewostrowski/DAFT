# DAFT
Delete all CSV (or any other format) files in a working directory older than the given time. Bash/zsh compatible.

#filemanagment #automation

MIT License

## USAGE
### Structure
`$ ./daft.sh [option1] [option2] [option3]`

### Configuration
There is no default file type. Before using DAFT, select the file type as described below. Script will automatically create `daft_config.cfg` to store selected file type.

#### Printing selected file type
To print the selected file type, use: `--config`
E.g.  `$ ./daft.sh --config`

To change the selected file type, use: `--config extension_name`
E.g. `$ ./daft.sh --config jpg`


### Removing files
To remove files older than a specific time (in days), use `-r` flag and provide a number of days since the last modification. This will only remove files with the extension chosen in the configuration.
E.g. `$ ./daft.sh -r 30`

### Moving files
To move files older than a specific time (in days), use `-m` flag and provide the directory and number of days since the last modification. This will only move files with the extension chosen in the configuration.
E.g. `$ ./daft.sh -m directory_name/another_directory 30`
