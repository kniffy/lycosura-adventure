; the boring engine shite for the Lycosurian Mysteries
; text adventure :^)

; NOTE beware of procedures that poke global vars

; https://tildas.org.

(module func
        (termsize
         lyco-display
         checkbounds
         matrix-ref
         checkeof
         in
         set-alist-value
         value
         get-command
         run-command
         filter-command
         lookahead)

        (import scheme
                chicken.base
                chicken.io
                chicken.port
                fmt
                srfi-1
                srfi-13)

        (define *h*)
        (define *w*)

        ; sets globar vars
        (define (termsize)
          (set!-values (*h* *w*) (terminal-size (current-output-port))))

        ; currently breaks deliberate white space
        (define (lyco-display str)
          (begin
            (termsize)
            (fmt #t (with-width *w* (wrap-lines str)) nl )))

        ; note if the check is the same size as the map
        (define (checkbounds x y)
          (cond
            ((< x 0) '#f)
            ((< y 0) '#f)
            ((> x 16) '#f)
            ((> y 7) '#f)
            ('#t)))

        ; saves us when theres not text set for the area
        (define (lookahead x y map)
          (cond
            ((string? (matrix-ref map x y)) '#t)
            ((zero? (matrix-ref map x y)) '#f)
            ((not (zero? (matrix-ref map x y))) (void))))

        ; matrix-ref returns the jth element of the ith row.
        (define (matrix-ref m i j)
          (vector-ref (vector-ref m i) j))

        (define (checkeof x)
          (if (eof-object? x)
              (exit)
              x))

        (define (in item list)
          ;;; Tells you if an item is in a list or not
          (cond ((member item list) #t) (else #f)))

        (define (set-alist-value key new-value alist)
          ;;; Return an alist with the updated value
          (alist-cons key (list new-value) (alist-delete key alist)))

        (define (value item alist)
          ;;; Returns the value from an alist
          (cadr (assoc item alist)))

        (define (get-command)
          ;;; Gets the command from the user and turns it into a list
          (map string->symbol (string-tokenize (string-downcase (checkeof (read-line))))))

        (define (run-command command)
          ;;; Run the users command.
          (if (> (length command) 0)
              (eval command)
              (display "Sorry I didn't understand that")))

        (define (filter-command command filter_list)
          ;;; Removes all words in the command that are not in the filter list. Preserves order of remaining words.
          (filter
            (lambda (x)
              (in x filter_list))
            command))
        
        ) ; module close paren

