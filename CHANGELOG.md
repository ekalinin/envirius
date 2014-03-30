Changelog
=========

0.5.1 (XX-04-2014)
------------------
* added ``plug_post_install_actions`` function for plugins
* python-plugin: added ``python`` symlink creation
* python-plugin: added ``pip`` installation

0.5.0 (28-03-2014)
------------------
* ``mk`` commands can store meta info about used plugins
* ``ls-envs`` can to read meta info
* improved autocomplete for ``mk``/``ls-versions``
* improved ``go`` plugin: added ``GOPATH`` into activation script
* added plugin for [python](https://www.python.org/)
* added ``plug_add_activate_script`` function for plugins
* added call for 'deactivate-' scripts during ``off``/``deactivate`` commands
* fixed ``go`` plugin: restore old values for ``GOROOT``/``GOPATH`` after
  deactivation of an environment
* fixed ``go`` plugin: improved activate-go content to be usabale after copy
* ``rm-envs`` output message if environment was successfully deleted
* ``ls-envs`` added environments sorting
* ``ls-envs`` renamed to ``ls`` (back)
* ``rm-envs`` renamed to ``rm`` (back)
* improved autocompletion for ``rm`` command

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
