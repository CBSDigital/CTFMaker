CTFMaker
========

A small MATLAB framework to create Autodesk formatted CTF LUTs by specifying chains of operators. Written by Benjamin Doherty.

## Class Diagram

A class diagram, ```Class digram.pdf``` is provided at the root of this repository. It shows the relationship between classes and how factory and template methods are used by subclasses to extend functionality.

## Purpose

This framework was created to aid in creating LUTs for compositors to use. Instead of manually entering data into a CTF file, we use the tool to generate CTF LUTs based on a series of operators. The framework relies on subclassing to add additional functionality, such as new operators or LUT types.

## Creating a new CTF LUT

To create a new LUT, you will subclass the ```LUT``` base class, the base class for all CTF LUTs. The base class provides core functionality, such as writing the LUT out to a file. At a minimum, your CTF LUT should implement the factory methods ```getCTFName()``` and ```getOperators()```. Operators are discussed below.

## Operators

An operator is a single operation performed on an image. CBS Digital only needed ```LUT1D``` and ```Matrix``` (color matrix) operators, but the full suite of Autodesk operators could be easily implemented.

## LUT1DHalfDomain

Because of the intricacies of specifying a 1D LUT with half floating point domain, a convenience class, ```LUT1DHalfDomain``` is utilized. Subclassers of ```LUT1DHalfDomain``` need only concern themselves will implementing ```getLUTValueForFloat()```. This is where the mathematical operations are specified for the operator.
