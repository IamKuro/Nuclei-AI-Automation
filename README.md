# Nuclei AI Automation Tool

## Overview
This is an automated tool for **Nuclei AI** that enables you to use multiple prompts directly. The tool comes bundled with **Subfinder** and **Httpx**, allowing you to scan a domain with a single command.

## Features
- Automatically installs **Nuclei AI**, **Subfinder**, and **Httpx**.
- Simplifies domain scanning with minimal input.
- Integrates multiple scanning tools for a comprehensive security assessment.

## Installation
Ensure you have **Go** installed on your system before proceeding.

```bash
# Clone the repository
git clone https://github.com/IamKuro/Nuclei-AI-Automation.git
cd nuclei-ai-automation

# Install dependencies
chmod +x install.sh
./install.sh
```

## Usage
Before using **Nuclei AI**, make sure you are logged in with your API key:

```bash
nuclei -auth <api>
```

Once authenticated, you can run the tool by simply typing:

```bash
bash /yourdirectory/BugHunt.sh
```

This will:
1. Use **Subfinder** to enumerate subdomains.
2. Use **Httpx** to check live hosts.
3. Run **Nuclei AI** to scan for vulnerabilities.

## Dependencies
- [Nuclei AI](https://github.com/projectdiscovery/nuclei)
- [Subfinder](https://github.com/projectdiscovery/subfinder)
- [Httpx](https://github.com/projectdiscovery/httpx)

## License
This project is licensed under the [MIT License](LICENSE).

## Contributions
Feel free to contribute by submitting issues or pull requests!

## Disclaimer
This tool is intended for security research and educational purposes only. The author is not responsible for any misuse of this tool.

