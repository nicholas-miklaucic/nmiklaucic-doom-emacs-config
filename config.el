;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Nicholas Miklaucic"
      user-mail-address "nicholas.miklaucic@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; 
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:

(setq doom-font (font-spec :family "Liga Plex Mono" :weight 'semibold :size 12))
(setq doom-variable-pitch-font (font-spec :family "Recursive Sans Linear Static" :size 15))
(setq doom-big-font (font-spec :family "Liga Plex Mono" :weight 'semibold :size 18))

;; for fira code workaround
(set-fontset-font t nil (font-spec :size 20 :name "Fira Code Symbol"))


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tomorrow-day)
(setq doom-themes-enable-bold t
      doom-themes-enable-italic t) 

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; because I'm apparently incapable of doing anything else
(map! :g "C-z" 'undo)

;; other keybindings

(after! helm
  (define-key helm-map "\t" 'helm-execute-persistent-action))


;; opinionated stuff
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq fill-column 100)
(add-hook 'prog-mode-hook 'auto-fill-mode)
(add-hook 'org-mode-hook 'auto-fill-mode)
(put 'scroll-left 'disabled nil)

;; don't start newlines in the middle of comments
(advice-remove #'newline-and-indent #'+default--newline-indent-and-continue-comments-a)

;; originally company-complete hook
(map! :g "C-;" 'just-one-space)
;; originally set to C-w, but that needs to change
(map! :g "C-c C-w" 'kill-region)
(map! :g "C-w" 'backward-kill-word)
;; originally set to like fifty keys
(map! :g "C-x C-e" 'eval-buffer)
;; I don't like doom's line behavior
(map! :g "C-a" 'beginning-of-line)
(map! :g "C-e" 'end-of-line)
;; I don't like smartparens
(after! smartparens
  (smartparens-global-mode -1))
;; I don't use C-t to transpose and imenu is so core to programming
(map! :g "C-t" 'helm-semantic-or-imenu)

(add-hook 'web-mode-hook #'rainbow-mode)
(add-hook 'css-mode-hook #'rainbow-mode)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(add-hook 'prog-mode-hook #'yas-minor-mode)

;; italicize comments and keywords
(custom-set-faces! '(font-lock-comment-face :slant italic) '(font-lock-keyword-face :slant italic))

(after! org
  (+org-pretty-mode))
 
;; ligatures
(load! "ligatures.el")
(add-hook 'prog-mode-hook 'fira-code-mode)

(after! rustic
  (setq lsp-rust-server 'rust-analyzer))
(setq rustic-lsp-server 'rust-analyzer)
(map! :mode rustic-mode :g "M-e" 'helm-lsp-code-actions)

(add-hook 'LaTeX-mode-hook #'prettify-symbols-mode)
(add-hook 'LaTeX-mode-hook #'magic-latex-buffer)
(setq TeX-electric-sub-and-superscript nil)

(use-package! visual-regexp-steroids
  :bind (("C-c r" . vr/replace)
         ("C-c q" . vr/query-replace)
         ("C-c m" . vr/query-mark)
         ("C-r" . vr/isearch-backward)
         ("C-s" . vr/isearch-forward)))
