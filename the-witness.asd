(asdf:defsystem "the-witness"
  :version "1.0.0"
  :depends-on (:cl-utilities)
  :components ((:module "src"
                :components
                ((:module "core"
                  :components
                  ((:file "point")))

                 (:module "puzzles"
                  :depends-on ("core" "util")
                  :serial t
                  :components
                  ((:file "solver")
                   (:file "tree-house-1")
                   (:file "tree-house-2")
                   (:file "tree-house-3")
                   (:file "tree-house-4")
                   (:file "tree-house-5")))

                 (:module "util"
                  :depends-on ("core")
                  :components
                  ((:file "pathfinding")
                   (:file "partition")))))))
