#lang racket

; (swapper.sym s1 s2 sym): S X S X S -> S
; returns s2 if sym=s1, s1 if sym=s2, else sym
(define swapper.sym
  (lambda (s1 s2 sym)
    (if (eq? sym s1)
        s2
        (if (eq? sym s2)
            s1
            sym))))

; (swapper.sexp s1 s2 sexp): S X S X SE -> SE
; returnes s-exp with all occurrences of s1 replaced with s2
(define swapper.sexp
  (lambda (s1 s2 sexp)
    (if (or (symbol? sexp) (number? sexp))
        (swapper.sym s1 s2 sexp)
        (swapper s1 s2 sexp))))

; (swapper s1 s2 slist): S X S X SL -> SL
; returns s-list with all occurrences of s1 replaced with s2
; : size(slist)=0 -> ()
; : else          -> ((swapper.sexp slist[0]) . (swapper slist[1..end]))
(define swapper
  (lambda (s1 s2 slist)
    (if (null? slist)
        (list)
        (cons (swapper.sexp s1 s2 (car slist)) (swapper s1 s2 (cdr slist))))))
