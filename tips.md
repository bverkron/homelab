## Move all files in directory except files that match pattern

Example:
Move all files in current directory into subdirectory called config. Exclude the config dir itself (will throw an error but cleaner to avoid it). If no files match the operation it will throw something like "mv: cannot stat '!(.env|compose.yaml|config)': No such file or directory"
`sudo mv !(.env|compose.yaml|config) config/`