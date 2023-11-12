FROM alpine:latest

RUN apk update
RUN apk add --update openjdk17 ncurses wget bash
RUN addgroup tal
RUN adduser -h /home/tal -g '' -s /bin/ash -G tal -D tal
RUN chown tal:tal /mnt

# compile
COPY --chown=tal:tal launch.sh /home/tal/launch.sh
COPY --chown=tal:tal in_docker_version.sh /home/tal/in_docker_version.sh
# leave root user
USER tal:tal

WORKDIR /home/tal/

RUN wget https://github.com/sbt/sbt/releases/download/v1.7.1/sbt-1.7.1.tgz && tar xvfz sbt-1.7.1.tgz  && rm sbt-1.7.1.tgz

# initialize sbt
RUN mkdir -p foo-build/project
WORKDIR /home/tal/foo-build
RUN printf 'ThisBuild / scalaVersion := "3.1.3"\nenablePlugins(JavaAppPackaging)\n' > build.sbt && echo 'addSbtPlugin("com.github.sbt" % "sbt-native-packager" % "1.9.4")' >> project/plugins.sbt && echo "exit"  | /home/tal/sbt/bin/sbt && mkdir -p ./src/main/scala && printf "object p {\n  def main(args: Array[String]): Unit = {\n    println(\"Hello world!\")\n  }\n}\n" > src/main/scala/p.scala  &&  printf "dist\nexit\n" | /home/tal/sbt/bin/sbt && ../sbt/bin/sbt universal:packageBin 

# create mount points
RUN mkdir /mnt/in && mkdir /mnt/out




