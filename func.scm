; the boring engine shite for the Lycosurian Mysteries
; text adventure :^)

; https://tildas.org.

(module func
        (
         checkbounds
         matrix-ref
         checkeof
         in
         set-alist-value
         value
         get-command
         run-command
         filter-command
         )

        (import (scheme)
                (chicken base)
                (chicken io)
                (srfi-1)
                (srfi-13))
 
        (define (checkbounds x y)
          (cond
            ((< x 0) '#f)
            ((< y 0) '#f)
            ((> x 16) '#f)
            ((> y 7) '#f)
            ('#t)))

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

