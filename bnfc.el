(defconst bnfc-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?\" "\"" table)
    (modify-syntax-entry ?\{ "(}1c" table)
    (modify-syntax-entry ?\} "){4c" table)
    (modify-syntax-entry ?- "_ 123" table)
    (modify-syntax-entry ?\n ">" table)
    table))

(define-derived-mode bnfc-mode prog-mode "BNFC mode"
  :syntax-table bnfc-mode-syntax-table
  (font-lock-fontify-buffer))
