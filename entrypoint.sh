cd /opt/crystal
git clone -b feature/win_preview https://github.com/jan-zajic/crystal.git .
git config --global user.email "jan.zajic@corpus.cz"
git config --global user.name "Jan Zajic"
git merge --no-edit origin/feature/win_process
git merge --no-edit origin/feature/win_compiler
make win