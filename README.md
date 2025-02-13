# npm-structured-logger 
[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

This repository provides a simple **Zsh** script to run an npm (Node.js) command and capture its output as **structured JSON logs**.

- **Uses**: Shell (Zsh), environment variables, sed for minor text processing  
- **Output**: Creates a JSON log file with timestamp, log level, and message for each line of the command’s output  
- **Extensible**: Easily adapt to other commands or frameworks  

## Contents

1. [Setup](#setup)  
2. [Usage](#usage)  
3. [Example .env](#example-env)  
4. [Script Explanation](#script-explanation)  
5. [License](#license)

## Setup

1. **Clone the Repo**:
    ```bash
    git clone https://github.com/your-username/npm-structured-logger.git
    ```
2. **Install Dependencies** (if any):
    ```bash
    cd npm-structured-logger
    # If your project has a package.json, run:
    npm install
    ```
3. **Create `.env` File** (optional):
    ```bash
    cp .env.example .env
    # Then edit .env to set your desired COMMAND and LOGFILE_PATH
    ```

## Usage

1. **Make the script executable**:
    ```bash
    chmod +x scripts/structured-logger.sh
    ```
2. **Run the script**:
    ```bash
    ./scripts/structured-logger.sh
    ```
   - The script will read `.env` (if present) to get `COMMAND` and `LOGFILE_PATH`.
   - It will log startup/shutdown events and each line of the command output in **JSON** format to `LOGFILE_PATH`.

## Example .env

```ini
COMMAND="npm run dev"         # or "npx docusaurus start", "node server.js", etc.
LOGFILE_PATH="log/dev.log"    # path to your log file
