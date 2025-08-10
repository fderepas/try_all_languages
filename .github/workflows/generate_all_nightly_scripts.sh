#!/bin/bash

m_counter=0
h_counter=4
for lang in ada apl assembly b bash bqn c clojure cobol cpp csharp dart dc elixir erlang fig fortran fsharp go golfscript groovy haskell j java jelly julia k kotlin lisp logo lua node ocaml perl php postscript powershell prolog python r raku ruby rust scala sql swift typescript vyxal zsh ; do
    echo $lang
    cat <<EOF > nightly_rebuild_$lang.yml
name: $lang Nightly Rebuild

on:
  # Trigger the workflow every night at 4:00 AM UTC
  schedule:
    - cron: '$m_counter $h_counter * * *'

  # Allows to run this workflow manually from the Actions tab
  workflow_dispatch:

jobs:
  run-tests-on-local-machine:
    runs-on: self-hosted

    steps:
      # Check out repository's code onto local machine
      - name: Check out code
        uses: actions/checkout@v4

      # Testing command
      - name: Build images
        run: |
          echo "Building images $lang"
          bash .github/workflows/rebuild_$lang.sh
EOF
    cat <<EOF > rebuild_$lang.sh
#!/bin/bash
set -e
set -x

cd \`dirname \$0\`
cd ../../docker/$lang

make
if [ \$? -eq 0 ]; then
    make test > /dev/null 2> /dev/null
    if [ \$? -eq 0 ]; then
        printf \\033[32mOK\\033[0m"\n"
        docker tag tal-$lang:latest fderepas/tal-$lang:latest
        docker push fderepas/tal-$lang:latest
    else
        printf \\033[31m$lang tests \KO\\033[0m"\n"
    fi
else
    printf \\033[31m$lang docker build KO\\033[0m"\n"
    exit 1
fi
EOF
    m_counter=$((m_counter+1))
    if [[ "$m_counter" -ge 60 ]]; then
        m_counter=$((m_counter-60))
        h_counter=$((h_counter+1))
    fi
done
