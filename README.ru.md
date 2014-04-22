envirius
========

``envirius`` — универсальный менеджер виртуальных окружений.

Идея
----

Обычно подобные утилиты узко специализированы под какой-то конкретный язык
программирования. Например:

  * [virtualenv](https://github.com/pypa/virtualenv/) для python
  * [rvm](https://github.com/wayneeseguin/rvm/) для ruby
  * [kerl](https://github.com/spawngrid/kerl/) для erlang
  * [nvm](https://github.com/creationix/nvm)/[nodeenv](https://github.com/ekalinin/nodeenv/) для node.js
  * и так далее

Но не редки случаи, когда в одном и том же окружении необходимо иметь
более одного языка программирования. Например, создать виртуальное окружение
с ``python2.6`` и ``node.js 0.10.24``. Именно такая идея и лежит в основе
``envirius``.

Кроме того, поддержка новых языков программирования реализована в виде
плагинов. То есть, процедура добавления поддержки нового языка максимальна
унифицирована (подробности — см. ниже).

Особенности
-----------

* простой и ясный дизайн
* легкая расширяемость
* покрытие тестами

Установка
=========

Установка тривиальна:

```bash
$ git clone git@github.com:ekalinin/envirius.git
$ cd envirius
$ make install
```

Далее, необходимо прописать в своём ``.bashrc`` файле следующие комманды:

```bash
[ -f "$HOME/.envirius/nv" ] && . ~/.envirius/nv
```

Удаление
========

Удаление так же тривиально, как и установка:

```bash
$ cd envirius
$ make uninstall
```

Доступные плагины
=================

В настоящий момент виртуальные окружения можно создавать для следующих
языков программирования:

* [erlang](http://erlang.org/)
* [rust](http://rust-lang.org/)
* [elixir](http://elixir-lang.org/)
* [julia](http://julialang.org/)
* [node.js](http://nodejs.org/)
* [python](https://www.python.org/)
* [go](http://golang.org/)
* [haskell](http://haskell.org/)
* [scala](http://scala-lang.org/)

Как пользоваться?
=================

Список подддерживаемых плагинов
-------------------------------

```bash
➥ nv ls-plugins
elixir
elixir-prebuilt
erlang
go-prebuilt
haskell
julia
node
node-prebuilt
python
rust
rust-prebuilt
scala
```

В настоящее время есть 2 типа плагинов:
* те, которые собирают язык из исходников (например, ``elixir``, ``erlang``)
* те, которые скачивают уже собранный бинарник под платформу (например,
  ``elixir-prebuilt``, ``go-prebuilt``)

Очевидно, что работа со вторым вариантом будет гораздо быстрее, так как сборка,
порой, занимает значительное время.

К сожалению, не все языки доступны в предварительно собранных пакетах. Поэтому
``*-prebuilt`` плагинов меньше, чем плагинов, которые собираются из исходных
кодов.

Cписок доступных версий для каждого из плагинов
-----------------------------------------------

```bash
➥ nv ls-versions --rust --erlang
* rust:
0.1         0.2         0.3         0.4         0.5
0.6         0.7         0.8         0.9
* erlang:
R10B-0    R10B-10   R10B-1a   R10B-2    R10B-3    R10B-4
R10B-5    R10B-6    R10B-7    R10B-8    R10B-9    R11B-0
R11B-1    R11B-2    R11B-3    R11B-4    R11B-5    R12B-0
R12B-1    R12B-2    R12B-3    R12B-4    R12B-5    R13A
R13B      R13B01    R13B02-1  R13B02    R13B03    R13B04
R14A      R14B      R14B01    R14B02    R14B03    R14B04
R15B      R15B01    R15B02    R15B02    R15B03-1  R15B03
R16A      R16B      R16B01    R16B02    R16B03-1  R16B03
17.0-rc1
```

Создать окружение
-----------------

```bash
➥ nv mk mixed-rust-erlang --rust=0.9 --erlang=17.0-rc1
Creating environment: mixed-rust-erlang ...
 * installing rust==0.9 ...
 * done (in 5 secs.)
 * installing erlang==17.0-rc1 ...
 * done (in 11 secs.)
```

Если необходимо активировать окружение сразу после создания, то:


```bash
➥ nv mk mixed-rust-erlang --rust=0.9 --erlang=17.0-rc1 --on
Creating environment: mixed-rust-erlang ...
....
Environment mixed-rust-erlang activated.
(mixed-rust-erlang) ➥ 
```

Активация/деактивация окружения
-------------------------------

### Активация в новой оболочке

По-умолчанию, окружение активируется в новой shell-оболочке:

```bash
➥ echo $$
112
➥ nv on mixed-rust-erlang
Environment mixed-rust-erlang activated.
(mixed-rust-erlang) ➥  echo $$
3437
```

То есть, чтобы выключить окружение, необходимо выйти из новой оболочки, то есть,
использовать ``exit`` или ``Ctrl-D``:

```bash
(mixed-rust-erlang) ➥  echo $$
3437
(mixed-rust-erlang) ➥  exit
➥ echo $$
112
```

### Активация в текущей оболочке

Если необходимо активировать окружение в текущем экземпляре оболочки, то:

```bash
➥ echo $$
5099
➥ nv on --same-shell mixed-rust-erlang
Environment mixed-rust-erlang activated.
(mixed-rust-erlang) ➥  echo $$
5099
```

Чтобы выйти из окружения используйте ``nv off``, а не ``exit``:

```bash
(mixed-rust-erlang) ➥  echo $$
5099
(mixed-rust-erlang) ➥ nv off
Environment mixed-rust-erlang was deactivated.
➥  echo $$
5099
```

Cписок окружений
----------------

```bash
➥ nv ls
Available environment(s):
mixed-rust-erlang
rust-0.9
erl-17-rc1
```

Активное окружение
------------------

```bash
(mixed-rust-erlang) ➥ nv current
mixed-rust-erlang
```

Если никакого окружения не активировано, то вернется пустая строка:

```bash
➥ nv current
➥ 
```

Выполнить команду в окружении без активации
-------------------------------------------

```bash
➥ nv do node-0.10.26 'npm -g ls'
```

Помощь
------

```bash
➥ nv --help
```

Помощь для команды
------------------

Например, для команды ``do``:

```bash
➥ nv do --help
```

Как добавить плагин?
====================

Плагины находятся в директории ``nv-plugins``. То есть, чтобы добавить плагин,
нужно разместить его именно в этой директории.

Обязательные элементы
---------------------

В самом простом случае достаточно реализовать 2 функции:

### plug_list_versions

Эта функция должна возвращать список доступных версий плагина. Например:

```bash
plug_list_versions() {
    local versions=$(curl -s "http://nodejs.org/dist" | \
                grep -v "node-" | \
                egrep -o '[0-9]+\.[0-9]+\.[0-9]+' | \
                sort -u -k 1,1n -k 2,2n -k 3,3n -t .)
    echo $versions
}
```

### plug_url_for_download

Эта функция должна возвращать полный url для скачивания архива для установки
плагина. Например:

```bash
plug_url_for_download() {
    local version=$1
    echo "http://nodejs.org/dist/v${version}/node-v${version}.tar.gz"
}
```

Если процедура установки плагина не типична, то можно вместо функции
``plug_url_for_download`` (или в дополнение к ней) объявить функцию
``plug_install``, реализующую полную логику сборки плагина и его
установки в новое виртуальное окружение. Дефолтную реализацию этой
функции можно посмотреть в файле ``src/nv-commands/mk``.

Необязательные элементы
-----------------------

### Переменные

* ``plug_list_versions_columns_count`` — определяющая, сколько будет
  колонок в выводе комманды ``nv versions`` для данного плагина.
* ``plug_list_versions_columns_size`` — переменная, определяющая, ширину колонки в
  символах в выводе комманды ``nv versions`` для данного плагина.
* ``plug_state`` — если переменная имеет значение ``disabled``, то данный плагин
  считается неактивным, и не будет учитываться при выполнении комманд:
  * mk
  * ls-versions
  * ls-plugins

### Функции

Функции перечислены в порядке их вызова в плагине:

* ``plug_check_deps`` — проверяет наличие зависимостией для плагина. Если
  возвращает непустую строку, то создание окружение прекращается. Пример можно
  посмотреть в
  [haskell](https://github.com/ekalinin/envirius/blob/master/src/nv-plugins/haskell#L20)
  плагине
* ``plug_install``  — переопределить весь процесс создания окружения
* ``plug_download`` — переопределить процесс скачивания архива
* ``plug_unpack`` — переопределить распаковку: ``tar xzf <archive-with-source>``
* ``plug_configure`` — переопределить конфигурацию: ``configure --prefix=<path-to-env>``
* ``plug_build`` — переопределить сборку ``make && make install``
* ``plug_build_env`` — переопределить копирование собранных бинарников в
  директрию окружения
* ``plug_post_install_actions`` — дополнительные действия после установки
  бинарников в окружение. Например, установка ``pip`` в пдагине для
  [python](https://github.com/ekalinin/envirius/blob/master/src/nv-plugins/python).

Зависимости
===========

* bash / zsh (базовая поддержка)
* curl / wget (для скачивания архивов)
* tar
* git
* gcc (для компиляции)
* bats (для тестирования)

Поддерживаемые ОС
=================

* ubuntu

Тестирование
============

Большая часть кода покрыта тестами. Для тестирования использован фреймворк
[bats](https://github.com/sstephenson/bats). Чтобы выполнить тесты:

```bash
➥ make tests
```

Большая часть кода покрыта тестами. Для тестирования использован фреймворк
[bats](https://github.com/sstephenson/bats). Тесты с нуля (с холодным кэшем)
занимают около 136 минут (включают скачивание архивов rust/erlang, их компиляцию
и установку на Core(TM) i7-3517U CPU @ 1.90GHz с 4 GB RAM).

С горячим кэшем (то есть, например, исходники ``elang``/``rust`` уже скачаны
и собраны бинарники) на ``Intel(R) Core(TM) i7-3517U CPU @ 1.90GHz`` с 4 GB
of RAM в Ubuntu 13.10 (32-bits) тесты занимают:

```bash
➥ times make tests
...

100 tests, 0 failure

real    8m26.572s
user    1m17.428s
sys     2m25.352s
```

История изменений
=================

См. файл [CHANGELOG.md](https://github.com/ekalinin/envirius/blob/master/CHANGELOG.md).

Лицензия
========

См. файл [LICENSE](https://github.com/ekalinin/envirius/blob/master/LICENSE).
