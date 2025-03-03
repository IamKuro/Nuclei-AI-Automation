# Nuclei AI Automation Tool

## Overview
This is an automated tool for **Nuclei AI** that enables you to use multiple prompts directly. The tool comes bundled with **Subfinder** and **Httpx**, allowing you to scan a domain with a single command.

## Features
![Layout BugHunt tool](https://github.com/user-attachments/assets/c02f46a1-dff3-42e0-b723-1e2c45c145f2)
- Automatically installs **Nuclei AI**, **Subfinder**, and **Httpx**.
- Simplifies domain scanning with minimal input.
- Integrates multiple scanning tools for a comprehensive security assessment.
- Easily customize scanning prompts to fit your needs.

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

## Customizing Prompts
You can modify or add new prompts to fit your scanning needs by editing the `scan.sh` script. The prompts are defined in the `VULNS` array within the script:

```bash
VULNS=(
  "Identify login pages vulnerable to authentication bypass."
  "Detect improper user authorization and privilege escalation vulnerabilities."
  "Identify user input fields allowing shell command execution."
)
```
To add a new vulnerability scan, simply append a new entry to the `VULNS` array:

```bash
VULNS=("Detect exposed API keys in public repositories.")
```
To remove a specific scan, delete the corresponding line from the `VULNS` array.

## Dependencies
- [Nuclei AI](https://github.com/projectdiscovery/nuclei)
- [Subfinder](https://github.com/projectdiscovery/subfinder)
- [Httpx](https://github.com/projectdiscovery/httpx)

## License
This project is licensed under the [MIT License](LICENSE).

## Disclaimer
This tool is intended for security research and educational purposes only. The author is not responsible for any misuse of this tool.

