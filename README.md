## Quick Install

### Linux / macOS
​```bash
# Cài tất cả skill vào project hiện tại
curl -fsSL https://raw.githubusercontent.com/megaads-vn/technical-skills/refs/heads/master/install.sh | bash

# Cài tất cả skill global
curl -fsSL https://raw.githubusercontent.com/megaads-vn/technical-skills/refs/heads/master/install.sh | bash -s -- --global

# Cài một skill cụ thể
curl -fsSL https://raw.githubusercontent.com/megaads-vn/technical-skills/refs/heads/master/install.sh | bash -s -- coding-convention

# Cài một skill cụ thể global
curl -fsSL https://raw.githubusercontent.com/megaads-vn/technical-skills/refs/heads/master/install.sh | bash -s -- coding-convention --global
​```

### Windows (PowerShell)
​```powershell
# Cài tất cả skill vào project hiện tại
irm https://raw.githubusercontent.com/megaads-vn/technical-skills/refs/heads/master/install.ps1 | iex

# Cài tất cả skill global
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/megaads-vn/technical-skills/refs/heads/master/install.ps1))) -Global

# Cài một skill cụ thể
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/megaads-vn/technical-skills/refs/heads/master/install.ps1))) coding-convention

# Cài một skill cụ thể global
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/megaads-vn/technical-skills/refs/heads/master/install.ps1))) coding-convention -Global
​```