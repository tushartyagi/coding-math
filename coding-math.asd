(asdf:defsystem :coding-math
    :name "coding-math"
    :version 0.0.1

    :author "Tushar Tyagi"
    
    :licence "GNU GPLv3"

    :description "Coding math exercises"

    :depends-on (:sketch :iterate)
    
    :serial t

    :components ((:module "src" :serial t
                          :components ((:file "package")
                                       (:file "utils")
                                       (:file "intro")
                                       (:file "trig")
                                       (:file "vec")
                                       (:file "particle")
                                       (:file  "velocity")
                                       (:file "episode-4")
                                       (:file "episode-5")
                                       (:file "episode-9")
                                       (:file "episode-10")
                                       (:file "episode-11")
                                       (:file "episode-12")
                                       (:file "episode-13")))))
