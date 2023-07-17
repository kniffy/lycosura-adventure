; this is a basic text walking sim, related to the Lycosurian Mysteries,
; and meant to be played via telnet/ssh

; it was planned to be a promotional tie in with the album release, but
; the decision was made to cancel, given the basis of the project was a
; deprecated python bbs daemon package, not to mention efforts needed to
; be focused on actually finishing the music.. 

; so here we are a couple years later, maybe listen to the music while
; playing this :^)

; when compiled and placed in /bin or similar, it is meant to be called
; as a user's login shell

; https://tildas.org.

(import (r7rs)
	(srfi-1)
	(srfi-13)
	(srfi-69)
	(scheme file))

; set up and definitions
; TODO: strings containing the descriptions, etc
(define area
  (vector '1 '0 '1))

(define actions
  (list "quit" "exit"))


; main loop here



; we need to define the list of actions the user can do
; and read the users text:
; north, south, east, west, xyzzy, look, help, quit
; do we need a whole parser, or just a match in a lookup table?

(import (r7rs)
        (srfi-1)
        (srfi-13)
        (srfi-69)
        (scheme file))


;;; General use functions

(define (in item list)
  ;;; Tells you if an item is in a list or not
  (cond ((member item list) #t) (else #f)))

(define (set-alist-value key new-value alist)
  ;;; Return an alist with the updated value
  (alist-cons key (list new-value) (alist-delete key alist)))

(define (value item alist)
  ;;; Returns the value from an alist
  (cadr (assoc item alist)))

;;; Get the command and make sense of it

(define (get-command)
  ;;; Gets the command from the user and turns it into a list
  (map string->symbol (string-tokenize (string-downcase (read-line)))))

(define (run-command command)
  ;;; Run the users command.
  (if (> (length command) 0)
      (eval command)
      (print "Sorry I didn't understand that")))

(define (filter-command command filter_list)
  ;;; Removes all words in the command that are not in the filter list. Preserves order of remaining words.
  (filter
   (lambda (x)
     (in x filter_list))
   command))

(define (repl)
  ;;; The REPL for user commands
  (let ((input (filter-command (get-command) user-commands)))
    (run-command input)
    (display ">")
    (repl)))

;;; Deal with the state of the game world

;;; I don't know how good of an idea the GHT is.
;;; I might try and break it up. But for now it should work

;(define save-file "./save_data.txt")

;(define GHT (make-hash-table))

;(define (save-ht ht file)
;  ;;; Save the given hash table to the given file
;  (call-with-output-file file (lambda (x) (write (hash-table->alist ht) x))))

;(define (load-ht file)
;  ;;; Return the hash table that has been stored in the given file
;  (if (file-exists? file)
;      (alist->hash-table (read (open-input-file file)))))

;;; User commands

;;; User commands use the tokens passed to them as indexes in the GHT

(define user-commands '(save-game load-game help exit-game debug-game))

;(define (debug-game)
;  ;;; Run any code the user inputs
;  (print (eval (read))))

;(define (save-game)
;  ;;; Save the game
;  (begin
;    (save-ht GHT save-file)
;    (print "The game has been saved")))

;(define (load-game)
;  ;;; Load the game from last save
;  (begin
;    (set! GHT (load-ht save-file))
;    (print "The game has been loaded")))

(define (exit-game)
  ;;; A way for the user to exit the game.
  (exit))

(define (help)
  ;;; Give the player help
  (print "You can\n" user-commands))

(define (look . location)
  ;;; Looking around
  (case (length location)
    ((0) ;;; Assume the player is asking about the current room
     (print "zero"))
    ((1) ;;; Describe the item that the player is looking at.
     (print "one"))
    )
  )

;;; Start the adventure

(define (main)
  (begin
    (print "Welcome to box land.\nThis is a prototype of a text adventure.")
    (display ">")
    (repl)
    ))

(main)
