(use-modules (gnu services)
             (gnu system shadow)
             (guix gexp)
             (guix channels)
             (gnu home)
             (gnu home services)
             (gnu home services guix)
             (gnu home services shells)
             (gnu packages)
             (gnu packages shells)
             (gnu packages emacs)   ;; Added for Emacs packages
             (nongnu packages mozilla))

;; =====================
;; Channel configuration
;; =====================

;; Define channels configuration
(define %nonguix-channel
  (channel
    (name 'nonguix)
    (url "https://gitlab.com/nonguix/nonguix")
    (branch "master")
    (introduction
      (make-channel-introduction
        "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
        (openpgp-fingerprint
          "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5")))))

(define %guix-science-channel
  (channel
    (name 'guix-science)
    (url "https://codeberg.org/guix-science/guix-science.git")
    (branch "master")
    (introduction
      (make-channel-introduction
        "b1fe5aaff3ab48e798a4cce02f0212bc91f423dc"
        (openpgp-fingerprint
          "CA4F 8CF4 37D7 478F DA05  5FD4 4213 7701 1A37 8446")))))

(define %guix-science-nonfree-channel
  (channel
    (name 'guix-science-nonfree)
    (url "https://codeberg.org/guix-science/guix-science-nonfree.git")
    (branch "master")
    (introduction
      (make-channel-introduction
        "58661b110325fd5d9b40e6f0177cc486a615817e"
        (openpgp-fingerprint
          "CA4F 8CF4 37D7 478F DA05  5FD4 4213 7701 1A37 8446")))))

(define %crypto-channel
  (channel
    (name 'crypto)
    (url "https://codeberg.org/attila.lendvai/guix-crypto.git")
    (branch "main")
    (introduction
      (make-channel-introduction
        "a6a78768c2f9d0f0e659b0788001e37e23dc26e4"
        (openpgp-fingerprint
          "69DA 8D74 F179 7AD6 7806  EE06 FEFA 9FE5 5CF6 E3CD")))))

(define %guix-cran-channel
  (channel
    (name 'guix-cran)
    (url "https://github.com/guix-science/guix-cran.git")
    (branch "master")))

(define %guix-channel
  (channel
    (name 'guix)
    (url "https://git.savannah.gnu.org/git/guix.git")
    (branch "master")
    (introduction
      (make-channel-introduction
        "9edb3f66fd807b096b48283debdcddccfea34bad"
        (openpgp-fingerprint
          "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA")))))

;; Combine all channels
(define home-channels
  (append 
    (list %nonguix-channel
          %guix-science-channel
          %guix-science-nonfree-channel
          %crypto-channel
          %guix-cran-channel
          %guix-channel)
    %default-channels))

;; =================
;; Package groupings
;; =================

;; Development tools and programming languages
(define development-packages
  '("gcc-toolchain"
    "make"
    "automake"
    "autoconf"
    "libtool"
    "pkg-config"
    "linux-libre-headers"
    "vscodium"
    "python"
    "emacs-next-pgtk"              ;; Added explicit Emacs package
    "emacs-doom-themes"  ;; Added for Doom Emacs
    "node"
    "openjdk"
    "plantuml"
    "wl-clipboard"
    "graphviz"
    "gnuplot"
    "shfmt"
    "shellcheck"
    "unzip"
    "sqlite"))

;; Python-specific packages and tools
(define python-packages
  '("python-ta-lib"
    "ta-lib"
    ;; Emacs Python development support
    "python-pip"
    "python-black"
    "python-pyflakes"
    "python-isort"))

;; Document preparation and publishing tools
(define document-packages
  '("texlive-scheme-basic"
    "texlive-dvipng"
    "texlive-dvisvgm"
    "pandoc"
    "markdown"
    "enchant"
    "hunspell"
    "hunspell-dict-en"))

;; Desktop applications and utilities
(define desktop-packages
  '("google-chrome-stable"
    "flatpak"
    "nextcloud-client"
    "libreoffice"
    "kdeconnect"
    "evolution"
    "zsh"
    "rbw"
    "spotifyd"))

;; =====================
;; Home environment setup
;; =====================

(home-environment
  (packages (specifications->packages
            (append development-packages
                    python-packages
                    document-packages
                    desktop-packages)))
  (services
    (append
      (list
        ;; Set environment variables
        (simple-service 'extended-env-vars-service
                      home-environment-variables-service-type
                      `(("PATH" . "$HOME/.config/emacs/bin:$HOME/.local/bin:$HOME/.npm-global/bin:$PATH")
                        ("SHELL" . ,(file-append zsh "/bin/zsh"))
                        ("XDG_DATA_DIRS" . "/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share:$XDG_DATA_DIRS")))

        ;; Configure channels for package sources
        (service home-channels-service-type home-channels)

        ;; Configure dotfiles
        (service home-files-service-type
                `((".guile" ,%default-dotguile)
                  (".Xdefaults" ,%default-xdefaults)))

        ;; Configure XDG application settings
        (service home-xdg-configuration-files-service-type
                `(("gdb/gdbinit" ,%default-gdbinit)
                  ("nano/nanorc" ,%default-nanorc)))

        ;; Configure ZSH as default shell
        (service home-zsh-service-type
                (home-zsh-configuration
                  (environment-variables
                    `(("DOOMDIR" . "$HOME/count_fig/dots/doom/"))))))

      %base-home-services)))
