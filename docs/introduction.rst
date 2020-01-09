.. include:: <isonum.txt>

Introduction
============

The idea behind the MATLAB\ |reg| eprfit toolbox: feasible ways for reproducible and reliable fitting of EPR spectra using the simulation algorithms provided by the `EasySpin <http://www.easyspin.org/>`_ toolbox.


Why MATLAB\ |reg|?
------------------

Simply because the `EasySpin <http://www.easyspin.org/>`_ toolbox for MATLAB\ |reg| is nowadays the de-facto standard for EPR spectral simulations. Other languages such as `Python <https://www.python.org/>`_ offer many advantages, but developing simulation routines for EPR spectra similar to what EasySpin provides seems more involved than creating a modular layer on top of the existing simulation routines and using the functionality provided by the MATLAB Optimization Toolbox\ |trade|.


Why a separate toolbox?
-----------------------

Fitting, *i.e.* optimisation, is far from being a simple and straight-forward task, particularly in such cases as often encountered by EPR spectroscopists with many parameters and no clear idea what a good set of starting parameters may look like.

Having both, a modular toolbox focussing on reproducibility and some guidance how best to apply the tools seems therefore sensible.
