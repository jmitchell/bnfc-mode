(defconst bnfc-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?\" "\"" table)
    (modify-syntax-entry ?\{ "(}1c" table)
    (modify-syntax-entry ?\} "){4c" table)
    (modify-syntax-entry ?- "_ 123" table)
    (modify-syntax-entry ?\n ">" table)
    table))

;; TODO: investigate "define", "delimiters", "views" keywords in the
;; latest source BNF.cf, but not documented at
;; https://bnfc.readthedocs.io/en/latest.

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

(defvar bnfc-font-lock-keywords
  (append
   `(
     (,(regexp-opt bnfc-keywords 'symbols) . font-lock-keyword-face)
     (,(regexp-opt bnfc-builtins 'symbols) . font-lock-builtin-face)
     )))


(define-derived-mode bnfc-mode prog-mode "BNFC"
  :syntax-table bnfc-mode-syntax-table
  (setq-local font-lock-defaults '(bnfc-font-lock-keywords
                                   nil nil nil nil))
  (font-lock-fontify-buffer))

(provide 'bnfc-mode)
