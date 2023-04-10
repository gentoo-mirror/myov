;; -*- no-byte-compile: t -*-

;; Directory Local Variables
;; For more information see (info "(emacs) Directory Variables")

((nil . ((projectile-project-type . make)
         (eval . (add-hook 'before-save-hook 'whitespace-cleanup))))
 (find-file . ((require-final-newline . t)
               (show-trailing-whitespace . t)
               (tab-width . 4)))
 (makefile-mode . ((indent-tabs-mode . t)))
 (yaml-mode . ((tab-width . 2))))
