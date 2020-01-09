.. matlab-eprfit documentation master file, created by
   sphinx-quickstart on Thu Jan  9 11:00:32 2020.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

.. include:: <isonum.txt>

matlab-eprfit documentation!
============================

Welcome! This is the documentation of the eprfit toolbox for MATLAB\ |reg|.
eprfit is a MATLAB\ |reg| toolbox for fitting EPR spectra using the algorithms from the MATLAB Optimization Toolbox\ |trade| and the EPR spectral simulation capabilities of the EasySpin toolbox.

.. warning::
  The eprfit toolbox is currently under active development and still considered in Alpha development state. Therefore, expect frequent changes in features and public APIs that may break your own code. Nevertheless, feedback as well as feature requests are highly welcome.


Features
--------

  * modular
  * focus on reproducibility
  * simple user interface via `YAML <https://yaml.org/>`_ files
  * extensively documented


Requirements
------------

  * Working MATLAB\ |reg| installation (the toolbox has been developed and tested with R2019b)
  * MATLAB Optimization Toolbox\ |trade|
  * `EasySpin toolbox <http://easyspin.org/>`_


Installation
------------

Install the package by adding the path to MATLAB\ |reg|::

    cd path/to/files
    addpath(genpath('eprfit'))


.. toctree::
   :maxdepth: 2
   :caption: Contents

   audience
   introduction
   contribute
   api/index


Indices and tables
------------------

* :ref:`genindex`
* :ref:`search`
