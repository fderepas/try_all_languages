FROM alpine:latest

RUN apk update
RUN apk add --update git openjdk18-jdk wget bash curl rlwrap --repository https://dl-3.alpinelinux.org/alpine/edge/testing/
RUN addgroup tal
RUN adduser -h /home/tal -g '' -s /bin/ash -G tal -D tal
RUN chown tal:tal /mnt

WORKDIR /home/tal
#RUN curl -O https://download.clojure.org/install/linux-install-1.11.1.1113.sh
#RUN chmod +x linux-install-1.11.1.1113.sh
#RUN ./linux-install-1.11.1.1113.sh

# copy launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

# leave root user
USER tal:tal
RUN mkdir /mnt/in
RUN mkdir /mnt/out

# compile and run a dummy program one so that all init structure are already here
RUN wget https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz && \
  export JAVA_HOME=/usr/lib/jvm/default-jvm/ && \
  tar xvfz apache-maven-3.8.6-bin.tar.gz && \
  rm -rf apache-maven-3.8.6-bin.tar.gz && \
  /home/tal/apache-maven-3.8.6/bin/mvn --version && \
  git clone https://github.com/clojure/clojure.git && \
  cd /home/tal/clojure && \
  JAVA_HOME=/usr/lib/jvm/default-jvm/ /home/tal/apache-maven-3.8.6/bin/mvn -Plocal -Dmaven.test.skip=true package && \
  printf  "(ns clojure.examples.hello\n   (:gen-class))\n(defn hello-world []\n   (doseq [ln (line-seq (java.io.BufferedReader. *in*))]\n   (println ln)))\n(hello-world)\n" > prog.clj && \
  java -jar /home/tal/clojure/clojure.jar prog.clj

