# Test data file naming convention

The current testing convention is such that file types are searched for and tested, so adding new files to be tested has two steps:
1. Name the file in a way that it can be searched for, and
2. Add all files of the same "type" using the same convention.

This is strictly to make it easier to expand testing by adding more test systems.

It's also conventional to zip data files and use the `with_zip_file()` convenience wrapper function in order to access the expanded file for testing.
For the remainder of this document, we just assume the starting file is zipped, and will leave out the `.zip` extension.

The convention for searching for files is to use `endswith(filename, suffix)` where the `suffix` is the last part of the filename, such as `my-system_suffix` indicates the following:
1. program, such as `_scm_adf.cub`, `_scm_adf.t41`, `_scm_band.t41`, `_program.ext`
  * You can use whatever you want. Consistency is key.
  * Here we're separating the suffix from the system name with an underscore.
  * The part after the decimal is probably already conventionally decided for whatever format you're using.
2. periodicity using `_periodic-<xyz>_` where `<xyz>` specifies which dimensions are periodic. 
  * e.g. `Cu_periodic-xyz_scm_band.t41` for a 3d periodic system
  * e.g. `CuO-surf_periodic-xy_scm_band.t41` for a 2d periodic system`
3. whether the data is actual charge density data using the `_fake_` keyword
  * e.g. `test_fake_flapw.charge`