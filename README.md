1) Build KConfig
================

make -C kconf/kconfig all_config


2) Run KConfig
==============

make xconfig


3) Generate configured variant
==============================

make transform

-> the generated code will be place to a "config" subfolder
