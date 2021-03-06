# Scrutinizer
Open source release of the 2007 Scrutinizer vision simulating web browser built with Adobe AIR. 

Get the latest, via manual install (req. Adobe Air), here: https://github.com/andyed/scrutinizer/raw/master/releases/scrutinizer_latest.air

See also http://andyedmonds.com/scrutinizer

# What's it for?
- In general, raising consciousness on the importance of visual design
- Studying how your page design enables visual search
- Observing users while using the browser to better enable you to understand their thought process

# How does it work?
Using an embedded browser in the Adobe Air platform, the Scrutinizer Browser, turned on with the Eye icon, creates a small window of clear visibility in the web page. Moving the mouse moves the visible area, with the remainder of the page both blurred and desaturated.  This simulates what your brain is actually seeing at any moment in time -- high res and color for a small angle of vision, and lower resolution with less color in the wider angles.

The software captures a bitmap of the page, blurs and desaturates it. The overlay is placed on top of the web page with a foveal sized mask enabling see through wherever the mouse is located.

# Related Works
- Commercial Service: http://www.attensee.com
- Academic Work
    - Alex Faaborg's MS Work: http://alumni.media.mit.edu/~faaborg/research/cornell/cg_fovealvision_site/index.htm (2001)
    - D. Lagun, E. Agichtein, "ViewSer: A Tool for Large-Scale Studies of Web Search Result Examination", to appear at CHI 2011. http://www.mathcs.emory.edu/~dlagun/pubs/sigir636-lagun.pdf
        - See also https://www.researchgate.net/publication/221300903_ViewSer_enabling_large-scale_remote_user_studies_of_web_search_examination_and_interaction
    - The Flashlight Project @ http://vlab.ethz.ch/flashlight/index.php.  Schulte-Mecklenbeck, Michael and Murphy, Ryan O. and Hutzler, Florian, Flashlight: Recording Information Acquisition Online (May 13, 2010). Available at SSRN: http://ssrn.com/abstract=1433225 or http://dx.doi.org/10.2139/ssrn.1433225

# Code Update Status
- Using Flex SDK 4.6 in 3.1 compatibility mode
- Toolbar & context menu not working
    - So built-in screencapture, bookmarks unavailable
- Disabled zoom blur interaction to enable mousewheel customization of fovea size for different ergnomocis

## TODO
- update to fx: namespace and 4.6
- long standing goal: swap guassian blur for more realistic low pass filter, see https://www.flickr.com/photos/32717188@N05/3082557059/
- Document calibrating foveal size for screen res/distance


# Contributors
- Creator: Andy Edmonds
- Coders: James Douma @ Nitobi, Inc. Andy Edmonds, Evan Mullins
- Designers: Evan Mullins, Dave Hallock
- Libraries: ColorMatrix derived from work by Mario Klingeman

# License
Copyright (c) 2012, Adndy Edmonds
All rights reserved.

Excepting ColorMatrix library licensed under Apache 2.0

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
