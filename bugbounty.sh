#!/bin/bash

clear
figlet -f slant "BugHunt"
echo "           by kenzoaja"
echo ""

# Meminta user untuk memasukkan domain target

read -p "Masukkan domain target: " TARGET

# Jika input kosong, keluar dari script

if [ -z "$TARGET" ]; then
echo "❌ Target tidak boleh kosong!"
exit 1
fi

echo "🟢 Target: $TARGET"
echo "-------------------------------------------"

RESULTS_DIR="results"
SUBDOMAINS_FILE="$RESULTS_DIR/${TARGET}_subdomains.txt"
LIVE_SUBDOMAINS_FILE="$RESULTS_DIR/${TARGET}_live.txt"
NUCLEI_LOG_FILE="$RESULTS_DIR/${TARGET}_nuclei.log"
NUCLEI_JSON_FILE="$RESULTS_DIR/${TARGET}_nuclei.json"

# Membuat folder results jika belum ada

mkdir -p "$RESULTS_DIR"

# Mengecek dan menginstall tools jika belum ada

check_and_install() {
local tool_name=$1
local install_cmd=$2

```
if ! command -v "$tool_name" &> /dev/null; then
    echo "⚠️  $tool_name tidak ditemukan! Menginstall..."
    eval "$install_cmd"
    echo "[✔] $tool_name berhasil diinstall."
else
    echo "[✔] $tool_name sudah terinstall."
fi

```

}

# Pastikan Subfinder, Httpx, dan Nuclei sudah terinstall

check_and_install "subfinder" "go install -v [github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest](http://github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest)"
check_and_install "httpx" "go install -v [github.com/projectdiscovery/httpx/cmd/httpx@latest](http://github.com/projectdiscovery/httpx/cmd/httpx@latest)"
check_and_install "nuclei" "go install -v [github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest](http://github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest)"

# Cek apakah tool berhasil diinstall setelah instalasi

if ! command -v subfinder &> /dev/null || ! command -v httpx &> /dev/null || ! command -v nuclei &> /dev/null; then
echo "❌ Gagal menginstall salah satu tool! Periksa kembali instalasi."
exit 1
fi

# Menjalankan Subfinder

echo "🚀 Mencari subdomain untuk: $TARGET"
subfinder -d "$TARGET" -o "$SUBDOMAINS_FILE"

# Menjalankan Httpx untuk mengecek subdomain yang aktif

echo "🌐 Mengecek subdomain yang aktif dengan Httpx..."
httpx -l "$SUBDOMAINS_FILE" -o "$LIVE_SUBDOMAINS_FILE"

# Jika tidak ada subdomain yang aktif, hentikan proses

if [ ! -s "$LIVE_SUBDOMAINS_FILE" ]; then
echo "❌ Tidak ada subdomain aktif ditemukan!"
exit 1
fi

# Daftar eksploitasi yang akan diuji secara otomatis

VULNS=(
"Identify login pages vulnerable to authentication bypass."
"Detect improper user authorization and privilege escalation vulnerabilities."
"Identify user input fields allowing shell command execution."
"Detect sensitive files exposed via traversal attacks."
"Check for traversal vulnerabilities allowing PHP file inclusion."
"Check for Local and Remote File Inclusion vulnerabilities in file upload and inclusion mechanisms."
"Scan for plaintext passwords stored in environment files and config files."
"Find HTTP request smuggling vulnerabilities by testing different content-length and transfer encoding headers."
"Detect insecure direct object references exposing unauthorized data."
"Check for weak JWT implementations and misconfigurations."
"Identify vulnerabilities where multiple parallel processes can manipulate shared resources."
"Identify SSRF vulnerabilities that exploit insecure header handling."
"Identify SSRF vulnerabilities that allow open redirection to attacker-controlled servers."
"Find SSRF vulnerabilities allowing remote server requests."
"Scan for XSS vulnerabilities inside inline event handlers such as onmouseover, onclick."
"Identify XSS vulnerabilities that bypass common web application firewalls."
"Identify stored XSS vulnerabilities where malicious scripts persist in the application."
"Find DOM-based XSS vulnerabilities where user input is reflected inside JavaScript execution."
"Identify reflected XSS vulnerabilities via GET parameters."
"Find common XSS patterns in response bodies."
"Detect SQL injection vulnerabilities using time delay techniques."
"Detect RCE vulnerabilities through insecure file upload mechanisms."
)

for vuln in "${VULNS[@]}"; do
echo "🔥 Scanning for: $vuln"

nuclei -l "$LIVE_SUBDOMAINS_FILE" -ai "$vuln" -o "$NUCLEI_LOG_FILE" -jsonl "$NUCLEI_JSON_FILE"

"$NUCLEI_JSON_FILE"
echo "✅ Done scanning: $vuln"
done

echo "🎯 Semua scan telah selesai untuk target: $TARGET"
echo "📂 Hasil scan tersedia di:"
echo "   📄 $SUBDOMAINS_FILE (Semua subdomain)"
echo "   📄 $LIVE_SUBDOMAINS_FILE (Subdomain aktif)"
echo "   📄 $NUCLEI_LOG_FILE (Hasil scan dalam format log)"
echo "   📄 $NUCLEI_JSON_FILE (Hasil scan dalam format JSON)"