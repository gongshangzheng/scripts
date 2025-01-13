(require 'magit)
(require 'subr-x)
(defun push-git-directories-to-github (directories &optional commit-message)
  "Push a list of directories to github using magit
DIRECTORIES is a list of directories to push to github,
COMMIT-MESSAGE is the message to use for the commit"
  (dolist (dir directories)
    (let ((commit-message (or commit-message
                              (read-string (format "%s Commit message:" dir)))))
      (when (and (file-directory-p dir)
                 (file-exists-p (concat (file-name-as-directory dir) ".git")))
        (let ((default-directory (file-name-as-directory dir)))
          (message "Processing directory %s" dir)
          (magit-stage-modified) ;; Add all files to the index
          (magit-call-git "commit" "-m" commit-message) ;; Commit the changes
          (magit-call-git "push" (magit-get-current-remote) (magit-get-current-branch)) ;; Push "master"the changes to github
          (message "Finished processing directory %s" dir)
          ;;
          )))
    )
  )
(defun select-git-directories (directories)
  "Prompt the user to select directories to push to GitHub from a list of DIRECTORIES.
Returns a list of selected directories."
  (let ((selected-dirs (completing-read-multiple "Select directories to push (comma-separated): " directories)))
    (message "You selected: %s" selected-dirs)
    selected-dirs))

(defun push-selected-git-directories-to-github ()
  "Push all git repositories to github"
  (interactive)
  (let ((git-dirs '("~/MyConf" "~/.doom.d" "~/org" "~/scripts" "~/Code/graduationDesign")))
    (let ((seleted-dirs (select-git-directories git-dirs)))
      ;; (message "Selected directories: %s" seleted-dirs)
      (push-git-directories-to-github seleted-dirs))
    )
  )
