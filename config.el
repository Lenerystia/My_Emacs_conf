;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Second_Brain/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Package's

;; (use-package neotree
;;   :config
;;   (setq neo-smart-open t
;;         neo-show-hidden-files t
;;         neo-window-width 35
;;         neo-window-fixed-size nil
;;         inhibit-compacting-font-caches t
;;         projectile-switch-project-action 'neotree-projectile-action)
;;         ;; truncate long file names in neotree
;;         (add-hook 'neo-after-create-hook
;;            #'(lambda (_)
;;                (with-current-buffer (get-buffer neo-buffer-name)
;;                  (setq truncate-lines t)
;;                  (setq word-wrap nil)
;;                  (make-local-variable 'auto-hscroll-mode)
;;                  (setq auto-hscroll-mode nil)))))

(add-to-list 'default-frame-alist '(undecorated . t))

;; Org-roam

(use-package org-roam
  :custom(org-roam-directory "~/Second_Brain/org")
  :bind (("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n l" . org-roam-buffer-toggle)))

(defun org-roam-node-insert-immediate (arg &rest args)
  (interactive "P")
  (let ((args (cons arg args))
        (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                  '(:immediate-finish t)))))
    (apply #'org-roam-node-insert args)))

;;(use-package org-multi-wiki
;; :config
;;  (org-multi-wiki-global-mode 1)
;;  :custom
;;  (org-multi-wiki-namespace-list '((personal "~/Second_Brain/org/personal/")
;;  (ops "~/Second_Brain/org/ops/")
;;  (programming "~/Second_Brain/org/programming/")))
  ;; Namespace of a wiki
  ;; (org-multi-wiki-default-namespace 'personal))

;;(use-package helm-org-multi-wiki)
;Org roam config:
;; (setq org-roam-directory (file-truename "c:\Users\marle\Desktop\NextCloud_synch\Second_Brain\org-roam")
;; (global-set-key (kbd "C-c n f") 'org-roam-node-find)
;; (global-set-key (kbd "C-c n i") 'org-roam-node-insert)
(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

;;Themes

;; Ulubione
(setq doom-theme 'doom-dracula)
;;(setq doom-theme 'doom-acario-light)
;;(setq doom-theme 'doom-acario-dark)
;;(setq doom-theme 'doom-tokyo-night)
;;(setq doom-theme 'doom-shades-of-purple)

(global-auto-revert-mode 1)

;; Export org to special directory

(defun org-export-output-file-name-modified (orig-fun extension &optional subtreep pub-dir)
  (unless pub-dir
    (setq pub-dir "~/Second_Brain/exported-org-files")
    (unless (file-directory-p pub-dir)
      (make-directory pub-dir)))
  (apply orig-fun extension subtreep pub-dir nil))
(advice-add 'org-export-output-file-name :around #'org-export-output-file-name-modified)


(setq display-line-numbers-type 'relative)

;; Keybinds
;; AVY
(global-set-key (kbd "M-g s") 'avy-goto-char)
(global-set-key (kbd "M-g g") 'avy-goto-char-timer)
(global-set-key (kbd "M-g f") 'avy-goto-line)
(global-set-key (kbd "M-g w") 'avy-goto-word-1)
(global-set-key (kbd "M-g e") 'avy-goto-word-0)

;;Evil
(map! "C-g C-j" #'evil-next-visual-line)
(map! "C-g C-k" #'evil-previous-visual-line)


;; kill ring
(map! :leader
      :desc "Browse kill ring" "y b" #'browse-kill-ring)

(map! :leader
      :desc "Consult yank from kill ring" "y y" #'consult-yank-from-kill-ring)

;;ORG-ROAM
(map! :leader
      :desc "Org-roam db sync" "o s" #'org-roam-db-sync)


(after! org
  (setq org-agenda-files '("~/agenda.org")))

(setq
   ;; org-fancy-priorities-list '("[A]" "[B]" "[C]")
   ;; org-fancy-priorities-list '("❗" "[B]" "[C]")
   org-fancy-priorities-list '("🟥" "🟧" "🟨")
   org-priority-faces
   '((?A :foreground "#ff6c6b" :weight bold)
     (?B :foreground "#98be65" :weight bold)
     (?C :foreground "#c678dd" :weight bold))
   org-agenda-block-separator 8411)

(setq org-agenda-custom-commands
      '(("v" "A better agenda view"
         ((tags "PRIORITY=\"A\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "High-priority unfinished tasks:")))
          (tags "PRIORITY=\"B\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Medium-priority unfinished tasks:")))
          (tags "PRIORITY=\"C\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Low-priority unfinished tasks:")))
          (tags "nearest"
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Tasks marked with customtag:")))

          (agenda "")
          (alltodo "")))))

;;(after! org
 ;; (add-to-list 'org-todo-keywords 'type '("WORK" . "a") t))
;;(after! org
;; (setq org-todo-keywords
;;     '((sequence "[ ](t)" "TODO" "AUCTANE(a)" "UNIVERSITY(u)" "WAIT(w)" "HOLD(h)" "OKAY(o)" "YES(y)" "NO(n)" "[?](W)" "IDEA(i)" "STRT(s)" "LOOP(r)" "PROJ(p)" "KILL(k)" "|" "DONE(d)" "[X](D)"))))
(after! org
  (setq org-todo-keywords
        '((sequence "TODO(t)" "AUCTANE(a)" "UNIVERSITY(u)" "PSYCHA(p)" "QUESTIONS(q)" "STORY(.)" "NARZEKANIE(e)" "WAIT(w)" "HOLD(h)" "IDEA(i)" "STRT(s)" "LOOP(r)" "PROJ(p)" "KILL(k)" "|" "DONE" )
          (sequence "[ ]" "[-]" "[?]" "|" "[X]")
          (sequence "OKAY" "NO" "|" "YES"))))
