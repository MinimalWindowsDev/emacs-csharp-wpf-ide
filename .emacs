;; Initialize package system
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; Refresh package contents
(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package if not already installed
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Disable splash screen globally
(setq inhibit-startup-screen t)

;; Disable menu bar globally
(menu-bar-mode -1)

;; Enable line numbering
(global-display-line-numbers-mode 1)

;; Suppress compilation warnings
(setq byte-compile-warnings '(not obsolete))

;; Install and configure required packages
(use-package company)
(use-package flycheck)
(use-package projectile)
(use-package format-all)
(use-package csharp-mode)

;; Try to install magit, but don't fail if it can't be installed
(use-package magit
  :ensure t
  :config
  (global-set-key (kbd "C-x g") 'magit-status)
  :catch (lambda (...)
           (message "Failed to load magit. Skipping...")))

(use-package treemacs
  :config
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-fringe-indicator-mode 'always)
  (when (display-graphic-p)
    (treemacs-resize-icons 44)))

(use-package treemacs-projectile
  :after (treemacs projectile))

(use-package neotree)

;; Set up file tree sidebar
(defun setup-file-tree-sidebar ()
  "Set up the file tree sidebar based on the Emacs mode (graphical or terminal)."
  (if (display-graphic-p)
      (treemacs)
    (neotree-show)))

;; Call the setup function when Emacs starts
(add-hook 'emacs-startup-hook 'setup-file-tree-sidebar)

;; C# mode hooks
(add-hook 'csharp-mode-hook #'company-mode)
(add-hook 'csharp-mode-hook #'flycheck-mode)
(add-hook 'csharp-mode-hook #'format-all-mode)

;; XAML mode hooks
(add-hook 'nxml-mode-hook #'company-mode)
(add-to-list 'auto-mode-alist '("\\.xaml\\'" . nxml-mode))

;; C# indentation
(setq csharp-indent-offset 4)

;; Projectile settings
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; Disable the compilation log buffer from popping up
(setq warning-minimum-level :error)

;; Function to build C# file
(defun build-csharp ()
  "Compile the current C# file."
  (interactive)
  (let* ((filename (file-name-nondirectory buffer-file-name))
         (basename (file-name-sans-extension filename))
         (build-dir (concat (file-name-directory buffer-file-name) "build/"))
         (exe-path (concat build-dir basename ".exe"))
         (csc-path "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\MSBuild\\Current\\Bin\\Roslyn\\csc.exe")
         (compile-command (format "cmd /c \"\"%s\" /out:\"%s\" \"%s\"\"" 
                                  csc-path exe-path buffer-file-name)))
    (unless (file-exists-p build-dir)
      (make-directory build-dir t))
    (compile compile-command)
    (setq last-built-csharp-executable exe-path)))

;; Function to run C# executable
(defun run-csharp ()
  "Run the last built C# executable."
  (interactive)
  (if last-built-csharp-executable
      (let ((output-buffer (get-buffer-create "*C# Output*")))
        (with-current-buffer output-buffer
          (erase-buffer)
          (insert (format "Running %s...\n\n" last-built-csharp-executable))
          (let ((process (start-process "csharp-process" output-buffer "cmd.exe" "/c" last-built-csharp-executable)))
            (set-process-sentinel
             process
             (lambda (proc event)
               (when (string-match "finished" event)
                 (process-send-string proc "\n")))))
          (display-buffer output-buffer))
        (delete-other-windows)
        (split-window-right)
        (other-window 1)
        (switch-to-buffer output-buffer))
    (message "No C# executable has been built yet. Use F5 to build first.")))

;; Global key bindings for C# build and run
(global-set-key [f5] 'build-csharp)
(global-set-key [f6] 'run-csharp)

;; Flycheck settings for C#
(with-eval-after-load 'flycheck
  (setq flycheck-csharp-language-version "7.3")
  (setq flycheck-msbuild-exe "C:/Program Files (x86)/Microsoft Visual Studio/2019/Professional/MSBuild/Current/Bin/amd64/MSBuild.exe")
  (setq flycheck-csharp-csc-executable "C:/Program Files (x86)/Microsoft Visual Studio/2019/Professional/MSBuild/Current/Bin/Roslyn/csc.exe"))

;; Display startup message
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "C# WPF XAML IDE environment loaded successfully!")))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(magit treemacs-projectile neotree format-all flycheck company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
