CiAO/IP: A Highly Configurable Aspect-Oriented IP Stack
=======================================================

*(CiAO is Aspect-Oriented)*

Building complex network protocol stacks for small resource-constrained devices is more than just porting a reference implementation. Due to the cost pressure in this area especially the memory footprint has to be minimized. Therefore, embedded TCP/IP implementations tend to be statically configurable with respect to the concrete application scenario.

CiAO/IP is a configurable TCP/IP stack for small embedded systems. Due to the use of software product line engineering techniques and aspect-oriented programming it exhibits an extraordinary degree of tailorability while retaining source code compatibility and maintainability.

Usage
-----

 1. Build KConfig: `make -C kconf/kconfig`
 2. Run KConfig: `make xconfig` or `make menuconfig`
 3. Generate configured variant: `make transform`

-> the generated code will be place in the subfolder *config*
