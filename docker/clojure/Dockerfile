FROM alpine:latest

RUN apk update
RUN apk add --update git openjdk21 wget bash curl rlwrap --repository https://dl-3.alpinelinux.org/alpine/edge/community/
RUN addgroup tal
RUN adduser -h /home/tal -g '' -s /bin/ash -G tal -D tal
RUN chown tal:tal /mnt

WORKDIR /home/tal

# copy launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

# leave root user
USER tal:tal
RUN mkdir /mnt/in
RUN mkdir /mnt/out

# compile and run a dummy program one so that all init structure are already here
RUN wget https://dlcdn.apache.org/maven/maven-3/3.9.11/binaries/apache-maven-3.9.11-bin.tar.gz && \
  export JAVA_HOME=/usr/lib/jvm/default-jvm/ && \
  tar xvfz apache-maven-*bin.tar.gz && \
  rm -rf apache-maven-*-bin.tar.gz && \
  /home/tal/apache-maven-*/bin/mvn --version && \
  git clone https://github.com/clojure/clojure.git && \
  cd /home/tal/clojure && \
  JAVA_HOME=/usr/lib/jvm/default-jvm/ /home/tal/apache-maven-*/bin/mvn -Plocal -Dmaven.test.skip=true package && \
  printf  "(ns clojure.examples.hello\n   (:gen-class))\n(defn hello-world []\n   (doseq [ln (line-seq (java.io.BufferedReader. *in*))]\n   (println ln)))\n(hello-world)\n" > prog.clj && \
  java -jar /home/tal/clojure/clojure.jar prog.clj

