# SASS Project Builder Scripts

This repository provides a set of batch scripts designed to streamline the setup and management of a SASS project. The scripts automate various tasks such as directory creation, npm initialization, dependency installation, and `package.json` script configuration.

## `Build.bat` - Basic SASS Project Setup

`Build.bat` is a script that lays the groundwork for a SASS project. It performs the following tasks:

- Creates the necessary project directories.
- Initializes an HTML file (`index.html`).
- Sets up SASS files (`style.scss` and partials).
- Creates batch files for executing SASS commands.
- Configures npm scripts for running and watching SASS.

This script is ideal for quickly setting up a basic SASS project structure.

## `Build-Choice.bat` - Customizable SASS Project Setup

`Build-Choice.bat` is a more advanced script that extends the functionality of `Build.bat` by providing an option to choose the project dependencies. It includes a simple menu using the `Choice` command, allowing you to choose between:

- Installing only SASS.
- Installing both SASS and Bootstrap.

These batch scripts automate the setup of a new SASS project. They handle the creation of project directories and files, and setup of npm scripts. This allows developers to focus more on coding and less on configuration, making these scripts a valuable tool for any developer working with SASS.