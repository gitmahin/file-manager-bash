# 🗂️ File Manager Bash Tool
This project is not just a utility - it’s a conceptual demonstration of how to perform unit testing on Bash scripts using `bats-core`.

## ✨ Features
- 📁 Create bulk serial files
- 📂 Create bulk serial folders
- 📝 Copy and create multiple serial files
- 🧾 Copy and create multiple serial folders

---

## ✅ Prerequisites
- Linux-based operating system
- Bash shell
- Git
- bats-core (automatically installed during setup)

---

## 🚀 Run in Development Mode
### 1. Clone the Repository
    ```bash
    git clone https://github.com/gitmahin/file-manager-bash.git
    cd file-manager-bash
    ```

### 2. Make the Install Script Executable
    ```bash
    chmod -v 755 install.dev.sh
    ./install.dev.sh
    ```
    *This script will install bats-core locally so that you can write and run unit tests for your Bash scripts.*

## 🔄 Keep in Sync with Core Project
To synchronize shared project files across all examples, run:
```bash
sudo bash files-dist.sh
```
This command copies the recommended core files to maintain consistency across various example implementations.

### 📦 Included Examples
- `example-npm` - Complete
- `example-zenity `- In progress

---

## 🧪 Run Unit Tests
While in the project root, simply run:
```bash
./test.sh
```
You can also filter tests by tags (space-separated):
```bash
./test.sh "copy-folders copy-files-default copy-files-modified"
```

> [!IMPORTANT]
> A step-by-step tutorial on using bats-core for Bash scripting and testing is in progress. Stay tuned at [tutorial.programmermahin.com](https://tutorial.programmermahin.com/devops/linux-and-bash-scripting/get-started-with-bash)

To dive deeper, refer to the official [bats-core](https://bats-core.readthedocs.io/en/stable/#) documentation.

> [!NOTE]
> This project is written with detailed inline comments so you can learn unit testing while reading the code.

---

## 🛠 Use as a User
If you just want to use the file manager tool:
```bash
git clone https://github.com/gitmahin/file-manager-bash.git
cd file-manager-bash
sudo bash install.sh
```

After installation, you can run the file manager tool globally using:
```bash
filemanager
```
---

## 📚 Learn More
- Full tutorial: [tutorial.programmermahin.com](https://tutorial.programmermahin.com/devops/linux-and-bash-scripting/get-started-with-bash)
- Source code: [GitHub Repository](https://github.com/gitmahin/file-manager-bash.git)
- bats-core docs: [bats-core.readthedocs.io](https://bats-core.readthedocs.io/en/stable/#)