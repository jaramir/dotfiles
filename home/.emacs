(setq-default show-trailing-whitespace t)
(put 'upcase-region 'disabled nil)

(custom-set-variables '(inhibit-startup-screen t))

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

; master branch
(unless (require 'el-get nil t)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (let (el-get-master-branch)
       (goto-char (point-max))
       (eval-print-last-sexp)))))

; stable branch
;
;(unless (require 'el-get nil t)
;  (url-retrieve
;   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
;   (lambda (s)
;       (goto-char (point-max))
;       (eval-print-last-sexp))))

(el-get 'sync)

(setq auto-mode-alist (cons '("\\Rakefile\\'" . ruby-mode) auto-mode-alist))

(defun turn-on-flyspell () (flyspell-mode 1))
(add-hook 'find-file-hooks 'turn-on-flyspell)
