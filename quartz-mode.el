;; -*- lexical-binding: t; -*-

;; TODO:
;; (yaml-parse-string "date: 2025-02-03
;; ;; title: Setting up Better BibTex in Zotero
;; ;; tags:
;; ;;   - bibtex
;; ;;   - zotero")

;; TODO: move zotero bibtex export location
(setq quartz-content-dir "~/quartz/content")

;; TODO: find-or-create file

(setq quartz-excluded-punctuation-regexp "[][{}!@#$%^&*()=+'\"?,.|;:~`‘’“”/]*")

(defun quartz--slug-no-punct (str &optional extra-characters)
  "Remove punctuation from STR.
Concretely, replace with an empty string anything that matches
the `quartz-excluded-punctuation-regexp'.

EXTRA-CHARACTERS is an optional string that has the same meaning
as the aforementioned variables.

From denote--slug-no-punct"
  (dolist (regexp (list quartz-excluded-punctuation-regexp
                        extra-characters))
    (when (stringp regexp)
      (setq str (replace-regexp-in-string regexp "" str))))
  str)

(defun quartz--slug-hyphenate (str)
  "Replace spaces and underscores with hyphens in STR.
Also replace multiple hyphens with a single one and remove any
leading and trailing hyphen.

From denote--slug-hyphenate."
  (replace-regexp-in-string
   "^-\\|-$" ""
   (replace-regexp-in-string
    "-\\{2,\\}" "-"
    (replace-regexp-in-string "_\\|\s+" "-" str))))

(defun quartz-sluggify-title (str)
  "From denote-sluggify-title."
  (downcase (quartz--slug-hyphenate (quartz--slug-no-punct str))))

;; TODO: (quartz-sluggify-title "Kpop's Vocabulary asdf\" $40 _")

(defun quartz-list-files ()
  (directory-files-recursively quartz-content-dir "\\.md\\'"))

(defun quartz-select-file ()
  "Returns path relative to home."
  (file-name-concat
   quartz-content-dir
   (completing-read "Quartz Notes: "
		    (mapcar (lambda (f) (file-relative-name f quartz-content-dir))
			    (quartz-list-files)) nil t)))

;; TODO: (capitalize (replace-regexp-in-string "-" " " "kpops-vocabulary-asdf-40"))

(defun quartz-find-file ()
  (interactive)
  (let ((selected (quartz-select-file)))
    (find-file selected)))

(defun quartz-insert-link (&optional text)
  "In format of Wikilinks, [[slugged-name | text]]."
  (interactive (list (when current-prefix-arg (read-from-minibuffer "Display text: "))))
  (let ((slugged (file-name-sans-extension (quartz-select-file))))
    (if text
	(insert (format "[[%s | %s]]" slugged text))
      (insert (format "[[%s]]" slugged)))))

(defun quartz-create-file (&optional init-title)
  "From denote--prepare-note."
  (interactive)
  (let* ((title (read-from-minibuffer "Title: " init-title))
	 (slugged (quartz-sluggify-title title))
	 (path (file-name-concat quartz-content-dir (file-name-with-extension slugged ".md")))
	 (buffer (find-file path)))
    (when (file-regular-p path)
      (user-error "A file named `%s' already exists" path))
    (with-current-buffer buffer
      (insert (format "---\ntitle: %s\ndate: %s\ntags:\n  -\n---\n" title (format-time-string "%Y-%m-%dT%T%z"))))))

;; (defun quartz-find-or-create-file (target)
;;   (interactive (list (quartz-select-file)))
;;   (if (and target (file-exists-p target))
;;       (find-file target)
;;     (quartz-create-file target)))

(defun quartz-current-buffer-url ()
  (interactive)
  (let*
      ((base (file-name-sans-extension (file-name-nondirectory (buffer-file-name))))
       (url (file-name-concat "http://localhost:8080/" base) ))
    (kill-new url)
    (message "Copied %s" url)))

(defvar-keymap quartz-mode-map
  :doc "Keymap for quartz-mode"
  "f" #'quartz-find-file
  "n" #'quartz-create-file
  "l" #'quartz-insert-link
  "u" #'quartz-current-buffer-url
  "d" (lambda () (interactive) (progn (dired quartz-content-dir "-lht") ; list, human-readable, time-sort
				      (dired-hide-details-mode))))
(bind-key "C-c n" quartz-mode-map)


;; TODO: do I need this? (consult-ripgrep quartz-content-dir)
