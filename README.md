# Setup R development environment for visual studio code on linux

- Install R and tk:

  - Arch Linux users can install R and tk with the following commands:

    ```sh
    sudo pacman -S tk
    sudo pacman -S r
    ```

- Install PIP and run :

  ```
  pip install -U radian
  ```

- Install Visual Studio Code Extensions :

  - `R` by Yuki Ueda
  - `R Debugger` by R Debugger

  - Launch VS Code Quick Open (Ctrl+P), enter following commands :

    ```sh
    ext install Ikuyadeu.r
    ext install RDebugger.r-debugger
    ```

- R console, `radian` :

  ```R
  install.packages("languageserver")
  install.packages("httpgd")

  remotes::install_github("ManuelHentschel/vscDebugger")

  ```

- Edit `settings.json` for Visual Studio Code, append the following :

  ```json
  "r.bracketedPaste": true,
  "r.rterm.linux": "/usr/bin/R",
  "r.lsp.path": "/usr/bin/R",
  "r.lsp.debug": true,
  "r.lsp.diagnostics": true,
  "r.rterm.option": [
  "--no-save",
  "--no-restore",
  "--r-binary=/usr/bin/R"
  ],
  ```

- Edit `~/.Rprofile` append the following :

  ```r
  source(file.path(Sys.getenv(
  if (.Platform$OS.type == "windows") "USERPROFILE" else "HOME"
  ), ".vscode-R", "init.R"))
  ```

- Create `tasks.json` file in `.vscode` directory of your project.

  - Write the following :

    ```json
    {
      "version": "2.0.0",
      "tasks": [
        {
          "label": "rplot",
          "command": "sh",
          "args": ["-c", "\"cat ${file} |  R --interactive --no-save\""],
          "type": "shell"
        }
      ]
    }
    ```

- Create `launch.json` file in `.vscode` directory of your project.

  - Write the following :

    ```json
    {
      "version": "0.2.0",
      "configurations": [
        {
          "type": "R-Debugger",
          "name": "Plot & Debug R-File",
          "request": "launch",
          "debugMode": "file",
          "workingDirectory": "${workspaceFolder}",
          "file": "${file}",
          "preLaunchTask": "rplot"
        },
        {
          "type": "R-Debugger",
          "name": "Debug R-File",
          "request": "launch",
          "debugMode": "file",
          "workingDirectory": "${workspaceFolder}",
          "file": "${file}"
        },
        {
          "type": "R-Debugger",
          "name": "Launch R-Workspace",
          "request": "launch",
          "debugMode": "workspace",
          "workingDirectory": "${workspaceFolder}"
        },
        {
          "type": "R-Debugger",
          "name": "Debug R-Function",
          "request": "launch",
          "debugMode": "function",
          "workingDirectory": "${workspaceFolder}",
          "file": "${file}",
          "mainFunction": "main",
          "allowGlobalDebugging": false
        },
        {
          "type": "R-Debugger",
          "name": "Debug R-Package",
          "request": "launch",
          "debugMode": "workspace",
          "workingDirectory": "${workspaceFolder}",
          "includePackageScopes": true,
          "loadPackages": ["."]
        },
        {
          "type": "R-Debugger",
          "request": "attach",
          "name": "Attach to R process",
          "splitOverwrittenOutput": true
        }
      ]
    }
    ```

## Debug and plot R code in visual studio code :

- Press `F5` to launch the debugger. Plot window will open. All debugging features are available (e.g. breakpoints, variable inspecting, stepping, etc.).

## Execute R code files in command line with plots, without debugging :

- Create a file named `run` in the root of the project.
  - Write the following code in the file :
    ```sh
        #!/bin/sh
        cat $1 |  R --interactive --no-save
    ```
- Run and plot R files with command `sh run my-r-script.r`

## Setup R for visual studio code jupyter notebooks

After setting up R and radian, you can use the following commands to setup R for jupyter notebooks.

- R console, `radian` :

  ```r
  install.packages('IRkernel')
  IRkernel::installspec()  # to register the kernel in the current R installation

  IRkernel::installspec(name = 'ir33', displayname = 'R 3.3') # Or your R version
  ```

- Install Visual Studio Code Extensions :

  - `Jupyter` by Microsoft
  - `Jupyter Notebook Renderer` by Microsoft
  - `Jupyter Keymap` by Microsoft

  - Launch VS Code Quick Open (Ctrl+P), enter following commands :

    ```sh
    ext install ms-toolsai.jupyter
    ext install ms-toolsai.jupyter-renderers
    ext install ms-toolsai.jupyter-keymap
    ```

  - To create a new notebook open the command palette (Windows: Ctrl + Shift + P, macOS: Command + Shift + P) and select the command "Jupyter: Create New Jupyter Notebook"

  - Select `R` kernel by clicking on the kernel picker in the top right of the notebook or by invoking the "Notebook: Select Notebook Kernel" command.
