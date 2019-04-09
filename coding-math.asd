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
                                       (:file "trig")
                                       (:file "vector")))))
