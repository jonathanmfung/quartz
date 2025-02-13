---
title: A Simple Way to Run Project Commands in Emacs
date: 2025-02-13T09:55:24-0800
tags:
  - emacs
---

I have a couple lines in my emacs configuration to help me discover and run commands at the project root. I usually use it for building and running a program.

Derived from project.el's `project-compile{:elisp}`

``` elisp
(defvar jf/project-compile-commands nil
  "alist of command names to command strings, to be executed by `compile`")

(defun jf/project-compile ()
  "Simple alist interface to compile a project, at the project-root."
  (interactive)
  (unless jf/project-compile-commands
    (error "jf/project-compile-commands is nil"))
  (let* ((completion-extra-properties
	  '(:annotation-function (lambda (completion)
				   (format "\t%s" (cdr (assoc completion minibuffer-completion-table))))))
	 (key (completing-read "Select compile-command" jf/project-compile-commands))
	 (cmd (cdr (assoc key jf/project-compile-commands))))
    ;; stole from `project-compile`
    (let ((default-directory (project-root (project-current t)))
          (compilation-buffer-name-function
           (or project-compilation-buffer-name-function
	       compilation-buffer-name-function)))
      (compile cmd))))
```

At the root, I set the local project's commands with a file:

```elisp title=".dir-locals.el"
;;; Directory Local Variables            -*- no-byte-compile: t -*-
;;; For more information see (info "(emacs) Directory Variables")

((nil .
      ((jf/project-compile-commands .
				 (("build serve" . "npx quartz build --serve")
				  ("version" . "npx quartz --version"))))))
```
