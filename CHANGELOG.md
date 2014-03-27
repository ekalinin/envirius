Changelog
=========

0.5.0 (XX-03-2014)
------------------
* ``mk`` commands can store meta info about used plugins
* ``ls-envs`` can to read meta info
* improved autocomplete for ``mk``/``ls-versions``
* improved ``go`` plugin: added ``GOPATH`` into activation script
* added plugin for [python](https://www.python.org/)

0.4.0 (19-03-2014)
------------------
* fixed ``on`` command if env's name is not entered
* ``activate``/``on`` commands: added env's name into prompt by default
* ``commands`` renamed to ``ls-commands``
* ``ls`` renamed to ``ls-envs``
* ``plugins`` renamed to ``ls-plugins``
* ``rm`` renamed to ``rm-envs``
* ``version`` renamed to ``ls-versions``
* added command ``ls-cache``
* added command ``rm-cache``
* added autocompletion
* added plugin for [go](http://golang.org/)

0.3.0 (22-02-2014)
------------------
* ``mk`` command accept empty environment name and generate it
  accordingly to plugins
* improved ``julia`` plugin (copied binaries not simlinks on them.
  importamt for ``cp`` command)
* added ``cp`` command for copy environments
* added ``mv`` command for renaming environments
* fixed error message if environment is not entered for ``on``/``activate``
* added option ``--prompt-enable`` for ``on``/``activate`` commands
* added plugin for [node.js](http://nodejs.org/)

0.2.1 (20-02-2014)
------------------
* fixed using ``download_file`` in ``mk`` command

0.2.0 (19-02-2014)
------------------

* ``plug_install`` is not mandatory function in the plugin file.
* added ``plug_url_for_download`` as replacement of the ``plug_install``
  in plugin body. Plugin's body now more easy to read/write.
* added tests for the most functions from ``nv_common``.
* fixed ``download_file`` from ``nv_common``: ``curl`` accounts redirects.
* standardized way to store archives in ``mk`` command.
* added plugin for [elixir](http://elixir-lang.org/).
* added plugin for [julia](http://julialang.org/).

0.1.0 (13-02-2014)
------------------

* Initial public release
