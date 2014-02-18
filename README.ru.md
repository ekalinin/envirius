envirius
========

``envirius`` — универсальный менеджер виртуальных окружений.

Чем отличается?
===============

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
унифицирована.

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
# активация envirius
if [ -e "~/.envirius/nv" ] ; then
    . ~/.envirius/nv
fi

# автоактивация окружения, если в текущей
# директории есть файл .envirius
if [ -e ".envirius" ] ; then
    nv on `cat .envirius`
fi
```

Доступные плагины
=================

В настоящий момент виртуальные окружения можно создавать для следующих
языков программирования:

* [erlang](http://erlang.org/)
* [rust](http://rust-lang.org/)

Как пользоваться?
=================

Проверить список подддерживаемых плагинов:

```bash
➥ nv plugins
erlang
rust
```

Проверить список доступных версий для каждого из плагинов:

```bash
➥ nv versions --rust --erlang
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

Создать окружение с конкретными версиями:

```bash
➥ nv mk mixed-rust-erlang --rust=0.9 --erlang=17.0-rc1
Creating environment: mixed-rust-erlang ...
 * installing rust==0.9 ...
 * done (in 5 secs.)
 * installing erlang==17.0-rc1 ...
 * done (in 11 secs.)
```

Получить список созданных окружений:

```bash
➥ nv ls
Available environment(s):
mixed-rust-erlang
rust-0.9
erl-17-rc1
```

Активировать окружение:

```bash
➥ mem on mixed-rust-erlang
Environment mixed-rust-erlang activated.
```

Проверить, если активное окружение:

```bash
➥ nv current
mixed-rust-erlang
```

Выключить окружение:

```bash
➥ nv off
Environment mixed-rust-erlang was deactivated.
```

Как написать новый плагин?
==========================

Плагины находятся в директории ``nv-plugins``. То есть, чтобы добавить плагин,
нужно разместить его именно в этой директории.

Обязательные элементы
---------------------

В самом простом случае достаточно реализовать 2 функции:

* ``plug_list_versions``, которая возвращает список доступных версий плагина
  через пробел.
* ``plug_url_for_download``, которая возвращает полный url для скачивания
  архива для установки плагина.

Если процедура установки плагина не типична, то можно вместо функции
``plug_url_for_download`` (или в дополнение к ней) объявить функцию
``plug_install``, реализующую полную логику сборки плагина и его
установки в новое виртуальное окружение. Дефолтную реализацию этой
функции можно посмотреть в файле ``src/nv-commands/mk``.


Необязательные элементы
-----------------------

* ``plug_list_versions_columns_count`` — переменная, определяющая, сколько будет
  колонок в выводе комманды ``nv versions`` для данного плагина.
* ``plug_list_versions_columns_size`` — переменная, определяющая, ширину колонки в
  символах в выводе комманды ``nv versions`` для данного плагина.
* ``plug_state`` — если переменная имеет значение ``disabled``, то данный плагин
  считается неактивным, и не будет учитываться при выполнении комманд:
  * mk
  * versions
  * plugins

Зависимости
===========

* bash
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
[bats](https://github.com/sstephenson/bats). Тесты с нуля (с холодным кэшем)
занимают около 136 минут (включают скачивание архивов rust/erlang, их компиляцию
и установку на Core(TM) i7-3517U CPU @ 1.90GHz с 4 GB RAM). С горячим кэшем
(elang/rust уже скачаны и собраны) тесты занимают 26 секунд.

Чтобы прогнать тесты, достаточно сделать:

```bash
➥ make tests
...

22 tests, 0 failures
```

История изменений
=================

См. файл [CHANGELOG.md](https://github.com/ekalinin/envirius/blob/master/CHANGELOG.md).

Лицензия
========

См. файл [LICENSE](https://github.com/ekalinin/envirius/blob/master/LICENSE).
