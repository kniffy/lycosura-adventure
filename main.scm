; this is a basic text walking sim, related to the Lycosurian Mysteries,
; and meant to be played via telnet/ssh
; it was planned to be a promotional tie in with the album release, but
; originally it was based on a python bbs package that is now deprecated;
; it contained its own server daemon which is overkill for a project as
; simple as this.

; when compiled and placed in /bin or similar, it is meant to be called
; as a user's login shell

(define map
  (make-vector 10 0))

(display map)

