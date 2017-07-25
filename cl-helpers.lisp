;;;; A personal standard library of useful tools.
(in-package :cl-user)
(defpackage cl-helpers
  (:use :cl)
  (:export :with-gensyms :once-only))
(in-package :cl-helpers)

;;; Macro heleprs.

;; Found in PCL chapter 8 page 101.
(defmacro with-gensyms ((&rest names) &body body)
  `(let ,(loop for n in names collect `(,n (gensym)))
     ,@body))

;; Found in PCL chapter 8 page 102.
(defmacro once-only ((&rest names) &body body)
  (let ((gensyms (loop for n in names collect (gensym))))
    `(let (,@(loop for g in gensyms collect `(,g (gensym))))
       `(let (,,@(loop for g in gensyms for n in names collect ``(,,g ,,n)))
          ,(let (,@(loop for n in names for g in gensyms collect `(,n ,g))) ,@body)))))
