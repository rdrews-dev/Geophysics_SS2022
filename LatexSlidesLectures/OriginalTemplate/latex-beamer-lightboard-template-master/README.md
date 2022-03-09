# LaTeX Beamer Lightboard Template

Beamer (LaTeX) template and usage instructions for Lightboard presentations created by [Professor Ed Scheinerman](https://en.wikipedia.org/wiki/Ed_Scheinerman). 

The [Lightboard](http://lightboard.info/) is a sheet of edge-lit glass that makes writing glow. The text is then automatically flipped for the camera. This allows instructors to face viewers when writing out concepts, diagrams, and equations. The Lightboard is basically a whiteboard optimized for video.

### Beamer

This Beamer template can be used instead of PowerPoint to create presentations to be projected on a screen. Since it is based on LATEX, it is excellent for presentations with mathematical formulas. We assume the user is already familiar with LATEX.

### Usage

This slide deck uses the ep-dark style which provides a particularly simple, clean design featuring white text on a black backgound. This is ideal for use on the Lightboard.

Keep it clean! Don’t put too many words on a slide.

*Note: You can find an example of the output of this template and usage instructions as the "lightboard-beamer.pdf" file bundled with this template package in the repository.*

#### Blocks

A **block** structure is useful for highlighting particular information.

#### Definition

The **deﬁnition** environment is a type of block used for deﬁnitions. Highlight the word you are deﬁning.

#### Pauses

The **pause** command is a mechanism for building up a slide in pieces.

#### Only

The **only** command provides more ﬁne control in revealing material on a slide.

#### Mathematics

Because Beamer is built in LATEX it does mathematics beautifully either inside a sentence or in display mode.

##### Aligned Equations

The **aligned** environment (in math mode) works well with Beamer and pauses

##### Figures

The **graphicx** package provides the **includegraphics** command. Prepare graphics with a drawing program using light colored lines and shapes on a black or transparent background. Save in a standard graphics format.

##### Math Extras

Use the **amsmath** and **amsthm** packages for additional math functionality.

