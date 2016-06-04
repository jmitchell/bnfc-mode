;;; bnfc.el --- Define context-free grammars for the BNFC tool

;; Copyright (C) 2016  Jacob Mitchell <jmitchell@member.fsf.org>

;; Author: Jacob Mitchell <jmitchell@member.fsf.org>
;; URL: https://github.com/jmitchell/bnfc-mode
;; Keywords: languages, tools
;; Version: 0.2
;; Package-Requires: ((emacs "24.3"))

;;; Commentary:

;; This package simplifies editing BNFC files.  BNFC is a tool for
;; defining context-free grammars as labelled-BNFs.  To use it, load
;; this file and type "M-x bnfc-mode".

;;; Code:

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.cf\\'" . bnfc-mode))

(defconst bnfc-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?\" "\"" table)
    (modify-syntax-entry ?\{ "(}1c" table)
    (modify-syntax-entry ?\} "){4c" table)
    (modify-syntax-entry ?- "_ 123" table)
    (modify-syntax-entry ?\n ">" table)
    table))

(defconst bnfc-keywords
  '("char"
    "coercions"
    "comment"
    "digit"
    "entrypoints"
    "eps"
    "internal"
    "layout"
    "letter"
    "lower"
    "nonempty"
    "position"
    "rules"
    "separator"
    "stop"
    "terminator"
    "token"
    "toplevel"
    "upper"))

(defconst bnfc-builtins
  '("Char"
    "Double"
    "Ident"
    "Integer"
    "String"))

(defconst bnfc-label
  (rx symbol-start
      (group upper (0+ (any letter digit "_")))
      symbol-end
      (0+ space)
      "."))

(defconst bnfc-production-variable
  ;; Regexp overlaps with BNFC-LABEL, but ordering of the
  ;; FONT-LOCK-DEFAULTS resolves the ambiguity. Strings matching both
  ;; regexps are treated as labels.
  (rx symbol-start
      (group upper (0+ (any letter digit "_")))
      symbol-end))

(defvar bnfc-font-lock-keywords
  (append
   `((,(regexp-opt bnfc-keywords 'symbols) . font-lock-keyword-face)
     (,(regexp-opt bnfc-builtins 'symbols) . font-lock-builtin-face)
     (,bnfc-label 1 font-lock-variable-name-face)
     (,bnfc-production-variable 1 font-lock-type-face))))

;;;###autoload
(define-derived-mode bnfc-mode prog-mode "BNFC"
  :syntax-table bnfc-mode-syntax-table
  (setq-local font-lock-defaults '(bnfc-font-lock-keywords)))

(provide 'bnfc)
;;; bnfc.el ends here
