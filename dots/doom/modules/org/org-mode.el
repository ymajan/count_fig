;; my org settings
(use-package org
  :custom
  ;; Set up directory and file paths first
  (org-directory "~/Documents/Codex/Org/")
  (org-id-locations-file (expand-file-name ".orgids" org-directory))
  (org-attach-id-dir (expand-file-name ".attach" org-directory))
  (org-default-notes-file (expand-file-name "GTD/inbox.org" org-directory))
  ;; Agenda files
  (org-agenda-files (list (expand-file-name "GTD/habits.org" org-directory)
                          (expand-file-name "GTD/next_actions.org" org-directory)))
  (org-agenda-skip-scheduled-repeats-after-deadline t)
  (org-todo-keywords '((sequence "TODO(t)" "DOING(g)" "|" "DONE(d)" "CANCELED(c)" "SKIPPED(s)")))
  ;; org-refile
  (org-refile-targets `((,(expand-file-name "GTD/incubator.org" org-directory) :maxlevel . 1)
                        (,(expand-file-name "GTD/next_actions.org" org-directory) :maxlevel . 1)))
  (org-refile-use-outline-path nil)       ; set to nil instead of 'file
  (org-outline-path-complete-in-steps nil)
  (org-refile-allow-creating-parent-nodes t)    ; changed to t instead of 'confirm
  (org-refile-use-cache nil)
  ;; Optional org settings
  (org-log-done 'time)
  (org-log-refile 'time)
  (org-startup-folded 'show2levels)
  (org-startup-with-inline-images t)
  (org-hide-emphasis-markers t)
  (org-pretty-entities t)
  (org-attach-dir-relative t)
  (org-log-into-drawer t)
  (org-ellipsis " ▼ ")
  :config
  ;; Capture templates
  (setq org-capture-templates
        '(("t" "Task Entry" entry
           (file org-default-notes-file)
           "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:SOURCE: %a\n:END:\n"
           :kill-buffer t)
          ("i" "Inbox Entry" entry
           (file org-default-notes-file)
           "* %?\n:PROPERTIES:\n:CREATED: %U\n:SOURCE: %a\n:END:\n"
           :kill-buffer t))))

;; org-journal
(use-package org-journal
  :defer t
  :init
  ;; Change default prefix key; needs to be set before loading org-journal
  (setq org-journal-prefix-key "C-c j ")
  :config
  (setq org-journal-dir (concat (file-name-as-directory org-directory) "Annals/")
        org-journal-file-type 'daily
        org-journal-file-format "%Y-%m-%d.org"
        org-journal-date-format "%Y-%m-%d \n* Dreams\n* Gratitude"
        org-journal-date-prefix "#+TITLE: "
        )
  )
