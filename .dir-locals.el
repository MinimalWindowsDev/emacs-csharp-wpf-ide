((nil . ((eval . (progn
                   ;; Project-specific settings can go here
                   ;; For example, you might want to set the project root for projectile:
                   (setq projectile-project-root (locate-dominating-file default-directory ".dir-locals.el"))
                   
                   ;; Or set specific compiler flags for this project:
                   (setq flycheck-csharp-language-version "8.0")  ; If this project uses a different C# version
                   
                   ;; Display startup message
                   (message "C# WPF XAML IDE project environment loaded successfully!"))))))
