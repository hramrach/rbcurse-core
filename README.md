# rbcurse-core

Contains core widgets and infrastructure of rbcurse ncurses toolkit. rbcurse helps to easily build
ncurses application for text terminals.

rbcurse-core contains basic widgets for constructing applications.  These include:

* field

* buttons - checkbox, radio, toggle

* list

* textview

* dialogs and popup

* table

* menu

* tabbedpane

* tree

* application header

* status line

Core intends to be : 

   * stable, 

   * have very few changes, 

   * be backward compatible.

   * simple, maintaible code

I shall be standardizing core over the next one or two minor versions. I shall also be simplifying code as much as possible to make it maintainable and more bug-free.

Method names in some classes may change, and one or two widget names will change. rbasiclistbox will become listbox while the old listbox that has moved to extras will become something like editlistbox. Similarly the old table will become edittable in extras, whereas tabularwidget will becoming table in core.
The new tabbedpane and messagebox will replace the old ones, while the old ones will move to /deprecated.

Color formatting needs to be standardized and a proper API firmed up for that, so user code does not get affected by internal changes. Similarly, work on textpad may get integrated into some widgets since it could simplify their code.

## Install

   `gem install rbcurse-core`        # just the core

   To install more:

   `gem install rbcurse-extras`        # the core, and extra stuff

   `gem install rbcurse`             # the core, extra and experimental stuff

## See also

* rbcurse - <http://github.com/rkumar/rbcurse/>

* rbcurse-core - <http://github.com/rkumar/rbcurse-core/>

* rbcurse-experimental - <http://github.com/rkumar/rbcurse-experimental/>

## License

  Same as ruby license.

  (c) copyright rkumar, 2008-2011.