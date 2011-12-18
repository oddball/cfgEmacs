#!/usr/bin/env tcsh


#Change http_proxy to what works on your company
#setenv http_proxy proxy.company.com:666

mkdir -p ~/.emacs.d/download 
mkdir -p ~/.emacs.d/elisp
 
cd ~/.emacs.d/download
wget http://www.iis.ee.ethz.ch/~zimmi/emacs/vhdl-mode-3.33.28.tar.gz
wget http://www.veripool.org/ftp/verilog-mode.el
wget http://www.specman-mode.com/specman-mode.el
tar -xvf vhdl-mode-3.33.28.tar.gz

\cp -f  vhdl-mode-3.33.28/vhdl-mode.el ~/.emacs.d/elisp 
\cp -f  verilog-mode.el ~/.emacs.d/elisp 
\cp -f  specman-mode.el ~/.emacs.d/elisp
 
 
#create bakup of original .emacs file 
if( -e ~/.emacs ) then
    mv ~/.emacs ~/.emacs.d/.emacs.bak_`date +%s` 
endif
 
echo "Writing new custom.el"
 
cat > ~/.emacs << EOF
(mwheel-install)
(custom-set-variables
 '(auto-compression-mode t nil (jka-compr))
 '(case-fold-search t)
 '(column-number-mode t)
 '(current-language-environment "ASCII")
 '(default-major-mode (quote text-mode) t)
 '(global-font-lock-mode t nil (font-lock))
 '(inhibit-startup-screen t)
 '(line-number-mode t)
 '(make-backup-files nil)
 '(mwheel-follow-mouse t)
 '(next-line-add-newlines nil)
 '(paren-activate t)
 '(paren-highlight-offscreen t)
 '(paren-message-show-linenumber (quote absolute))
 '(paren-mode (quote sexp) nil (paren))
 '(require-final-newline t)
 '(shell-mode-hook (quote (start-shell font-lock-mode)))
 '(show-paren-mode t nil (paren))
 '(show-paren-style (quote parenthesis))
 '(specman-auto-endcomments nil)
 '(specman-auto-newline nil)
 '(specman-basic-offset 3)
 '(specman-highlight-beyond-max-line-length nil)
 '(specman-max-line-length 100)
 '(transient-mark-mode t)
 '(uniquify-buffer-name-style (quote forward))
 '(verilog-auto-newline nil)
 '(vhdl-array-index-record-field-in-sensitivity-list nil)
 '(vhdl-electric-mode nil)
 '(vhdl-end-comment-column 790)
 '(vhdl-entity-file-name (quote (".*" . "\\\&-e")))
 '(vhdl-inline-comment-column 840)
 '(vhdl-prompt-for-comments nil))
 
(custom-set-faces
 '(default ((t (:foreground "black" :background "white"))))
 '(paren-match ((t (:foreground "black" :background "darkseagreen2"))))
 '(secondary-selection ((t (:foreground "Red" :background "paleturquoise"))))
 '(specman-highlight-beyond-max-line-length-face ((t nil))))



(defun prepend-path ( my-path )
(setq load-path (cons (expand-file-name my-path) load-path)))
	  
(defun append-path ( my-path )
(setq load-path (append load-path (list (expand-file-name my-path)))))
;; Look first in the directory ~/elisp for elisp files
(prepend-path "~/.emacs.d/elisp")
;; Load verilog mode only when needed
(autoload 'verilog-mode "verilog-mode" "Verilog mode" t )
;; Any files that end in .v, .dv or .sv should be in verilog mode
(add-to-list 'auto-mode-alist '("\\\.[ds]?v\\\'" . verilog-mode))
;; Any files in verilog mode should have their keywords colorized
(add-hook 'verilog-mode-hook '(lambda () (font-lock-mode 1)))


;; Load specman mode only when needed 
(autoload 'specman-mode "specman-mode" "Specman mode" t )

;; Any files that end in .e cetera should be in specman mode 
(setq auto-mode-alist (cons '("\\\.e\\\'" . specman-mode) auto-mode-alist)) 

(put 'downcase-region 'disabled nil)

;; XEmacs goto line style.
(define-key esc-map "g" 'goto-line)
EOF
 
cd ~/
