# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Attribute:: clojure
#
# Copyfree (F) 2014 Carlton Stedman
#

default["wergstation"]["clojure"] = {
  # leinengen
  "lein" => {
    "plugins" => [["cider/cider-nrepl", "0.8.0-SNAPSHOT"],
                  ["jonase/eastwood", "0.1.4"],
                  ["lein-ancient", "0.5.5"],
                  ["lein-difftest", "2.0.0"],
                  ["lein-exec", "0.3.4"],
                  ["lein-gorilla", "0.3.3"],
                  ["lein-kibit", "0.0.8"],
                  ["lein-localrepo", "0.5.3"],
                  ["lein-marginalia", "0.8.0"],
                  ["speclj", "3.1.0"]],
    "clojure" => "1.6.0"
  }
}
