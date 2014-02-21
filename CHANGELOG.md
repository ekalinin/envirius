Changelog
=========

0.3.0 (XX-XX-2014)
------------------
* 'mk' command accept empty environment name and generate it
  accordingly to plugins
* improved 'julia' plugin (copied binaries not simlinks on them.
  importamt for 'cp' command)
* added 'cp' command for copy environments
* added 'mv' command for renaming environments

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
