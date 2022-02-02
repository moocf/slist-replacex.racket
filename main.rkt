#lang racket

; (slist.replacex-sym s1 s2 sym): S X S X S -> S
; returns s2 if sym=s1, s1 if sym=s2, else sym
(define slist.replacex-sym
  (lambda (s1 s2 sym)
    (if (eq? sym s1)
        s2
        (if (eq? sym s2)
            s1
            sym))))

; (slist.replacex-sexp s1 s2 sexp): S X S X SE -> SE
; returnes s-exp with all occurrences of s1 replaced with s2
(define slist.replacex-sexp
  (lambda (s1 s2 sexp)
    (if (or (symbol? sexp) (number? sexp))
        (slist.replacex-sym s1 s2 sexp)
        (slist.replacex s1 s2 sexp))))

; (slist.replacex s1 s2 slist): S X S X SL -> SL
; returns s-list with all occurrences of s1 replaced with s2
; : size(slist)=0 -> ()
; : else          -> ((slist.replacex-sexp slist[0]) . (slist.replacex slist[1..end]))
(define slist.replacex
  (lambda (s1 s2 slist)
    (if (null? slist)
        (list)
        (cons (slist.replacex-sexp s1 s2 (car slist)) (slist.replacex s1 s2 (cdr slist))))))
