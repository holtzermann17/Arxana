(defsystem "arxana"
    :version "1"
    :author "Joe Corneli <holtzermann17@gmail.com>"
    :licence "Public Domain"
    :components
    ((:file "packages")
     (:file "utilities" :depends-on ("packages"))
     (:file "database" :depends-on ("utilities"))
     (:file "queries" :depends-on ("packages"))))
