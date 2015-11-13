VMIPrototype
=============

Prototype of a virtual musical instrument with a reconfigurable layout of keys. The implementation allows for controlling the instrument via hands-free gestures with a LeapMotion hand tracker.

Intructions for Installation
----------------------------
This project was developed in Processing with the Soundcipher library and a LeapMotion wrapper library. You need to install:
- The processing IDE from https://processing.org/
- The soundcipher library from http://explodingart.com/soundcipher/
- The wrapper fro the processing libraries at https://github.com/voidplus/leap-motion-processing

Installing both libraries requires putting them on the libraries folder for your processing installation. You may follow this short tutorial to do so: http://www.learningprocessing.com/tutorials/libraries/

Using the Application
-----------------------
Make sure that the LeapMotion tracker is plugged into one of your USB ports. Open the PDE file from this project and run it on the Processing IDE.

Playing music involves moving your hand over the tracked volume to hit the circles on the display, at the moment there is no calibration process so learn by doing.

Clicking (with an immediate release) on a note clones it. Dragging it notes allow the user to reconfigure the layout of the notes. Overlapping notes allows you to create chords.
